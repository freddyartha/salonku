<?php

namespace App\Services;

use App\Repositories\ServiceRepository;
use Illuminate\Http\Request;

class ServiceService
{
    protected $serviceRepository;

    public function __construct(ServiceRepository $serviceRepository)
    {
        $this->serviceRepository = $serviceRepository;
    }

    public function getPaginatedService(int $id, Request $request)
    {
        $options = [
            'per_page' => $request->query('per_page', 10),
            'search' => $request->query('search'),
            'sort' => $request->query('sort') ?? 'desc',
        ];
        return $this->serviceRepository->getPaginatedService($id, $options);
    }
}
