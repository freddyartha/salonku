<?php

namespace App\Services;

use App\Repositories\PengeluaranRepository;
use App\Repositories\ServiceRepository;
use Illuminate\Http\Request;

class PengeluaranService
{
    protected $repository;

    public function __construct(PengeluaranRepository $repository)
    {
        $this->repository = $repository;
    }

    public function getPaginatedBySalonId(int $id, Request $request)
    {
        $options = [
            'cabang_id' => $request->query('cabang_id') ?? null,
            'per_page' => $request->query('per_page', 10),
            'search' => $request->query('search'),
            'sort' => $request->query('sort') ?? 'desc',
        ];
        return $this->repository->getPaginatedBySalonId($id, $options);
    }

    public function getById(int $id)
    {
        return $this->repository->findById($id);
    }

    public function deleteById(int $id)
    {
        return $this->repository->deleteById($id);
    }

    public function store(array $data)
    {
        return $this->repository->create($data);
    }

    public function update(array $data, int $id)
    {
        return $this->repository->update($data, $id);
    }
}
