<?php

namespace App\Repositories;

use App\Models\PaymentMethod;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class PaymentMethodRepository
{
    public function findById(int $id)
    {
        return PaymentMethod::find($id);
    }

    public function create(array $data): PaymentMethod
    {
        return PaymentMethod::create($data);
    }

    public function update(array $data, $id): PaymentMethod
    {
        $res = $this->findById($id);
        $res->update($data);

        return $res;
    }

    public function delete(int $id)
    {
        return PaymentMethod::findOrFail($id)->delete();
    }


    public function getPaginatedBySalonId(int $salonId, array $options): LengthAwarePaginator
    {
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = PaymentMethod::query()->where("id_Salon", $salonId);

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama', 'like', "%{$search}%")
                    ->orWhere('kode', 'like', "%{$search}%");
            });
        }

        $query->orderBy('created_at', $sort);

        return $query->paginate($perPage);
    }
}
