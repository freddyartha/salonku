<?php

namespace App\Repositories;

use App\Models\Client;
use App\Models\Product;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class ClientRepository
{
    public function findById(int $id)
    {
        return Client::find($id);
    }

    public function create(array $data): Client
    {
        return Client::create($data);
    }

    public function update(array $data, $id): Client
    {
        $res = $this->findById($id);
        $res->update($data);

        return $res;
    }

    public function delete(int $id)
    {
        return Client::findOrFail($id)->delete();
    }


    public function getPaginatedBySalonId(int $salonId, array $options): LengthAwarePaginator
    {
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = Client::query()->with('salon')->where("id_Salon", $salonId);

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama', 'like', "%{$search}%")
                    ->orWhere('alamat', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%");
            });
        }

        $query->orderBy('created_at', $sort);

        return $query->paginate($perPage);
    }
}
