<?php

namespace App\Services;

use App\Repositories\SalonRepository;

class SalonService  
{
    protected $salonRepository;

    public function __construct(SalonRepository $salonRepository)
    {
        $this->salonRepository = $salonRepository;
    }

    public function getSalonById(int $id)
    {
        return $this->salonRepository->findById($id);
    }

    public function store(array $data)
    {
        return $this->salonRepository->create($data);
    }

    public function update(array $data, int $id)
    {
        return $this->salonRepository->update($data, $id);
    }
}
