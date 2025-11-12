<?php

namespace App\Repositories;

use App\Models\Product;
use App\Models\ServiceItem;
use App\Models\ServiceManagement;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class ServiceManagementRepository
{
    public function findById(int $id)
    {
        return ServiceManagement::with(['serviceItems', 'client', 'services', 'paymentMethod', 'salon', 'cabang', 'promos'])->find($id);
    }

    public function create(array $data): ServiceManagement
    {
        return DB::transaction(function () use ($data) {
            $items = $data['service_items'] ?? [];
            unset($data['service_items']);

            $services = $data['services'] ?? [];
            unset($data['services']);

            $idPromo = $data['id_promo'] ?? null;
            unset($data['id_promo']);

            // Simpan data utama ke tabel service_management
            $management = ServiceManagement::create($data);

            // Jika ada item detail, simpan ke tabel service_item
            if (!empty($items)) {
                foreach ($items as $item) {
                    $management->serviceItems()->create([
                        'id_service_management' => $management->id,
                        'nama_service' => $item['nama_service'],
                        'deskripsi' => $item['deskripsi'] ?? null,
                        'harga' => $item['harga'],
                    ]);
                }
            }

            // insert to table tr_id_service_management
            if (!empty($services)) {
                foreach ($services as $serviceId) {
                    $management->services()->attach($serviceId, [
                        'id_service' => $serviceId,
                        'id_service_management' => $management->id,
                        'created_at' => now(),
                    ]);
                }
            }

            $management->promos()->attach($idPromo, [
                'id_service_management' => $management->id,
                'created_at' => now(),
            ]);

            // Load relasi yang dibutuhkan
            return $management->load(['serviceItems', 'client', 'services', 'paymentMethod', 'salon', 'cabang', 'promos']);
        });
    }

    public function update(array $data, $id): ServiceManagement
    {
        return DB::transaction(function () use ($id, $data) {
            $items = $data['service_items'] ?? [];
            unset($data['service_items']);

            $services = $data['services'] ?? [];
            unset($data['services']);

            $idPromo = $data['id_promo'] ?? null;
            unset($data['id_promo']);

            // Ambil data utama
            $management = ServiceManagement::findOrFail($id);

            // Update data utama
            $management->update($data);

            // ===== Update service_items (hapus dan buat ulang) =====
            $management->serviceItems()->delete();

            if (!empty($items)) {
                foreach ($items as $item) {
                    $management->serviceItems()->create([
                        'id_service_management' => $management->id,
                        'nama_service'          => $item['nama_service'],
                        'deskripsi'             => $item['deskripsi'] ?? null,
                        'harga'                 => $item['harga'],
                    ]);
                }
            }

            // ===== Update relasi many-to-many services =====
            // Gunakan sync agar otomatis tambah/hapus pivot
            if (!empty($services)) {
                $pivotData = [];
                foreach ($services as $serviceId) {
                    $pivotData[$serviceId] = [
                        'id_service'             => $serviceId,
                        'id_service_management'  => $management->id,
                        'created_at'             => now(),
                        'updated_at'             => now(),
                    ];
                }

                $management->services()->sync($pivotData);
            } else {
                // Jika tidak ada services dikirim, kosongkan relasi
                $management->services()->detach();
            }

            if ($idPromo != null) {
                $management->promos()->sync($idPromo, [
                    'id_service_management' => $management->id,
                    'created_at' => now(),
                ]);
            } else {
                $management->promos()->detach();
            }

            // Load relasi yang dibutuhkan untuk response
            return $management->load(['serviceItems', 'client', 'services', 'paymentMethod', 'salon', 'cabang', 'promos']);
        });
    }

    public function delete(int $id)
    {
        return ServiceManagement::findOrFail($id)->delete();
    }


    public function getPaginatedBySalonId(int $salonId, array $options): LengthAwarePaginator
    {
        $cabangId = $options['cabang_id'];
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = ServiceManagement::with(['serviceItems', 'client', 'services', 'paymentMethod', 'salon', 'cabang', 'promos'])->where("id_Salon", $salonId);

        if ($cabangId != null) {
            $query->where("id_cabang", $cabangId);
        }

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('catatan', 'like', "%{$search}%")
                    ->orWhereHas('client', function ($qc) use ($search) {
                        $qc->where('nama', 'like', "%{$search}%");
                    })->orWhereHas('serviceItems', function ($qc) use ($search) {
                        $qc->where('nama_service', 'like', "%{$search}%");
                    })->orWhereHas('services', function ($qc) use ($search) {
                        $qc->where('nama', 'like', "%{$search}%");
                    });
            });
        }

        $query->orderBy('created_at', $sort);

        return $query->paginate($perPage);
    }
}
