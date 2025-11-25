<?php

namespace App\Repositories;

use App\Models\Pengeluaran;
use App\Models\Service;
use Carbon\Carbon;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class PengeluaranRepository
{

    public function getPaginatedBySalonId(int $salonId, array $options): LengthAwarePaginator
    {
        $cabangId = $options['cabang_id'];
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = Pengeluaran::query()->with('cabangs', 'salon')->where("id_Salon", $salonId);

        if ($cabangId != null) {
            $query->whereHas('cabangs', function ($q) use ($cabangId) {
                $q->where('id_cabang', $cabangId);
            })->orDoesntHave('cabangs');
        }

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama', 'like', "%{$search}%")
                    ->orWhere('deskripsi', 'like', "%{$search}%");
                // ->orWhere('harge', 'like', "%{$search}%");
            });
        }

        $query->orderBy('created_at', $sort);

        return $query->paginate($perPage);
    }

    public function findById(int $id)
    {
        return Pengeluaran::with('cabangs', 'salon')->find($id);
    }

    public function deleteById(int $id)
    {
        return Pengeluaran::findOrFail($id)->delete();
    }

    public function create(array $data): Pengeluaran
    {
        // pisahkan cabangs dari data utama
        $cabangs = $data['cabangs'] ?? [];

        // hapus cabangs dari data utama sebelum create
        unset($data['cabangs']);

        // buat service
        $service = Pengeluaran::create($data);

        // jika ada cabang, attach ke pivot
        if (!empty($cabangs)) {
            $service->cabangs()->attach($cabangs);
        }
        return $service->load('cabangs', 'salon');
    }

    public function update(array $data, $id): Pengeluaran
    {
        // pisahkan cabangs dari data utama
        $cabangs = $data['cabangs'] ?? [];

        // hapus cabangs dari data utama sebelum create
        unset($data['cabangs']);

        $service = $this->findById($id);
        $service->update($data);

        // jika ada cabang, attach ke pivot
        if (!empty($cabangs)) {
            $service->cabangs()->sync($cabangs);
        }

        return $service->load('cabangs', 'salon');
    }

    public function readWithPeriod($salonId,  $cabangId, $fromDate, $toDate)
    {
        $query = Pengeluaran::with('cabangs')
            ->where('id_salon', $salonId)
            ->whereBetween('created_at', [
                Carbon::parse($fromDate)->startOfDay()->utc(),
                Carbon::parse($toDate)->endOfDay()->utc()
            ]);

        // Filter cabang jika diberikan
        if ($cabangId != null) {
            $query->whereHas('cabangs', function ($q) use ($cabangId) {
                $q->where('id_cabang', $cabangId);
            });
        }

        $data = $query->get();

        // Total dari field harga
        $total = $data->sum('harga');

        return $total;
    }
}
