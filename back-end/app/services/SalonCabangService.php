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
