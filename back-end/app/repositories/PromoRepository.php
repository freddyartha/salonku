<?php

namespace App\Repositories;

use App\Models\Promo;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class PromoRepository
{
    public function findById(int $id)
    {
        return Promo::find($id);
    }

    public function create(array $data): Promo
    {
        return Promo::create($data);
    }

    public function update(array $data, $id): Promo
    {
        $res = $this->findById($id);
        $res->update($data);

        return $res;
    }

    public function delete(int $id)
    {
        return Promo::findOrFail($id)->delete();
    }


    public function getPaginatedBySalonId(int $salonId, array $options): LengthAwarePaginator
    {
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = Promo::query()->where("id_Salon", $salonId);

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama', 'like', "%{$search}%")
                    ->orWhere('deskripsi', 'like', "%{$search}%");
            });
        }

        $query->orderBy('created_at', $sort);

        return $query->paginate($perPage);
    }
}
