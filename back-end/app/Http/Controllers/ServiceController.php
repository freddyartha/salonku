<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\StoreServiceRequest;
use App\Http\Resources\ListServiceResource;
use App\Http\Resources\ServiceResource;
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

    // Menampilkan data berdasarkan ID
    public function readServiceById($id)
    {
        $response = $this->serviceService->getServiceById($id);

        $resource = new ServiceResource($response);

        return ApiResponse::success(
            data: $resource,
        );
    }

    public function deleteServiceById($id)
    {
        $this->serviceService->deleteById($id);

        return ApiResponse::success(
            message: "Service deleted successfully",
        );
    }

    public function storeService(StoreServiceRequest $request)
    {
        $salon = $this->serviceService->storeService($request->validated());

        return ApiResponse::success(
            data: new ServiceResource($salon)
        );
    }

    public function updateService(StoreServiceRequest $request, int $id)
    {
        $salon = $this->serviceService->updateService($request->validated(), $id);

        return ApiResponse::success(
            data: new ServiceResource($salon)
        );
    }
}
