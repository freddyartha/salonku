<?php

namespace App\Repositories;

use App\Models\Service;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class ServiceRepository
{

    public function getPaginatedService(int $salonId, array $options): LengthAwarePaginator
    {
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = Service::query()->with('cabangs', 'salon')->where("id_Salon", $salonId);

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama', 'like', "%{$search}%")
                    ->orWhere('deskripsi', 'like', "%{$search}%")
                    ->orWhere('harge', 'like', "%{$search}%");
            });
        }

        $query->orderBy('created_at', $sort);

        return $query->paginate($perPage);
    }

    public function findById(int $id)
    {
        return Service::with('cabangs', 'salon')->find($id);
    }

    public function deleteById(int $id)
    {
        return Service::findOrFail($id)->delete();
    }

    public function create(array $data): Service
    {
        $res = Service::create($data);
        return $res->load('cabangs', 'salon');
    }

    public function update(array $data, $id): Service
    {
        $res = $this->findById($id);
        $res->update($data);

        return $res->load('cabangs', 'salon');
    }
}
