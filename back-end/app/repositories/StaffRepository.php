<?php

namespace App\Repositories;

use App\Models\UserSalon;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class StaffRepository
{
    public function findById(int $id)
    {
        return UserSalon::with('cabangs',)->find($id);
    }

    public function deactivateStaff($id)
    {
        $res = $this->findById($id);
        return $res->update(['aktif' => false]);
    }

    public function promoteStaff($id, bool $promote): UserSalon
    {
        $res = $this->findById($id);
        $res->update(['level' => $promote ?  3 : 2]);
        return $res->load('cabangs');
    }

    public function update(array $data, $id): UserSalon
    {
        $res = $this->findById($id);
        $res->update($data);

        return $res->load('cabangs');
    }

    public function getPaginatedBySalonId(int $salonId, array $options): LengthAwarePaginator
    {
        $perPage = $options['per_page'] ?? 10;
        $search = $options['search'];
        $sort = $options['sort'] ?? 'desc';

        $query = UserSalon::query()->with('cabangs')->where("id_Salon", $salonId)->where("level", "!=", 1)->where("aktif", 1);

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
