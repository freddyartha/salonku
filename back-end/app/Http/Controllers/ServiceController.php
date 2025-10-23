<?php

namespace App\Http\Controllers;

use App\Http\Resources\ListServiceResource;
use App\Services\ServiceService;
use Illuminate\Http\Request;

class ServiceController extends Controller
{
    protected $serviceService;

    public function __construct(ServiceService $serviceService)
    {
        $this->serviceService = $serviceService;
    }


    public function getPaginatedService(int $salonId,  Request $request)
    {
        $response = $this->serviceService->getPaginatedService($salonId, $request);

        if ($response->isEmpty()) {
            return response()->json([
                'data' => [],
                'message' => 'No services found',
            ], 200);
        }

        return ListServiceResource::collection($response);
    }
}
