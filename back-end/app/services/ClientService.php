<?php

namespace App\Services;

use App\Repositories\ClientRepository;
use Illuminate\Http\Request;

class ClientService
{
    protected $repository;

    public function __construct(ClientRepository $repository)
    {
        $this->repository = $repository;
    }

    public function getById(int $id)
    {
        return $this->repository->findById($id);
    }

    public function store(array $data)
    {
        return $this->repository->create($data);
    }

    public function update(array $data, int $id)
    {
        return $this->repository->update($data, $id);
    }

    public function deleteById(int $id)
    {
        return $this->repository->delete($id);
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
