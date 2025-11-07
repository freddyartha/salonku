<?php

namespace App\Services;

use App\Repositories\StaffRepository;
use Illuminate\Http\Request;

class StaffService
{
    protected $repository;

    public function __construct(StaffRepository $repository)
    {
        $this->repository = $repository;
    }

    public function getById(int $id)
    {
        return $this->repository->findById($id);
    }

    public function update(array $data, int $id)
    {
        return $this->repository->update($data, $id);
    }

    public function deactivateStaff(int $id)
    {
        return $this->repository->deactivateStaff($id);
    }

    public function promoteStaff(int $id, bool $promote)
    {
        return $this->repository->promoteStaff($id, $promote);
    }

    public function getPaginatedBySalonId(int $id, Request $request)
    {
        $options = [
            'per_page' => $request->query('per_page', 10),
            'search' => $request->query('search'),
            'sort' => $request->query('sort') ?? 'desc',
        ];
        return $this->repository->getPaginatedBySalonId($id, $options);
    }
}
