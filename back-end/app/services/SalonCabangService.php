<?php

namespace App\Services;

use App\Repositories\SalonCabangRepository;
use Illuminate\Http\Request;

class SalonCabangService
{
    protected $salonCabangRepository;

    public function __construct(SalonCabangRepository $salonCabangRepository)
    {
        $this->salonCabangRepository = $salonCabangRepository;
    }

    public function getSalonById(int $id)
    {
        return $this->salonCabangRepository->findById($id);
    }

    public function store(array $data)
    {
        return $this->salonCabangRepository->create($data);
    }

    public function update(array $data, int $id)
    {
        return $this->salonCabangRepository->update($data, $id);
    }

    public function deleteById(int $id)
    {
        return $this->salonCabangRepository->delete($id);
    }

    public function getPaginatedCabangBySalonId(int $id, Request $request)
    {
        $options = [
            'per_page' => $request->query('per_page', 10),
            'search' => $request->query('search'),
            'sort' => $request->query('sort') ?? 'desc',
        ];
        return $this->salonCabangRepository->getCabangBySalonIdPaginated($id, $options);
    }
}
