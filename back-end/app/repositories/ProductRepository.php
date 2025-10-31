<?php

namespace App\Repositories;

use App\Models\Product;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class ProductRepository
{
    public function findById(int $id)
    {
        return Product::with('salon', 'supplier')->find($id);
    }

    public function create(array $data): Product
    {
        $res = Product::create($data);
        return $res->load('salon', 'supplier');
    }

    public function update(array $data, $id): Product
    {
        $res = $this->findById($id);
        $res->update($data);

        return $res->load('salon', 'supplier');
    }

    public function delete(int $id)
    {
        return Product::findOrFail($id)->delete();
    }


    public function getPaginatedBySalonId(int $salonId, array $options): LengthAwarePaginator
    {
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = Product::query()->with('salon')->where("id_Salon", $salonId);

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama', 'like', "%{$search}%")
                    ->orWhere('brand', 'like', "%{$search}%")
                    ->orWhere('satuan', 'like', "%{$search}%");
            });
        }

        $query->orderBy('created_at', $sort);

        return $query->paginate($perPage);
    }
}
