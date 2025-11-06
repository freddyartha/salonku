<?php

namespace App\Repositories;

use App\Models\SalonCabang;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class SalonCabangRepository
{
    public function findById(int $id)
    {
        return SalonCabang::find($id);
    }

    public function create(array $data): SalonCabang
    {
        return SalonCabang::create($data);
    }

    public function update(array $data, $id): SalonCabang
    {
        $salon = $this->findById($id);
        $salon->update($data);

        return $salon;
    }

    public function delete(int $id)
    {
        return SalonCabang::findOrFail($id)->delete();
    }


    public function getCabangBySalonIdPaginated(int $salonId, array $options): LengthAwarePaginator
    {
        $cabangId = $options['cabang_id'];
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = SalonCabang::query()->where("id_Salon", $salonId);

        if ($cabangId != null) {
            $query->where("id", $cabangId);
        }

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama', 'like', "%{$search}%")
                    ->orWhere('alamat', 'like', "%{$search}%")
                    ->orWhere('phone', 'like', "%{$search}%");
            });
        }

        $query->orderBy('created_at', $sort);

        return $query->paginate($perPage);
    }
}
