<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\ProductRequest;
use App\Http\Requests\ServiceManagementRequest;
use App\Http\Resources\ProductResource;
use App\Http\Resources\ServiceManagementResource;
use App\Services\ServiceManagementService;
use Illuminate\Http\Request;

class ServiceManagementController extends Controller
{
    protected $service;

    public function __construct(ServiceManagementService $service)
    {
        $this->service = $service;
    }

    //create
    public function store(ServiceManagementRequest $request)
    {
        $salon = $this->service->store($request->validated());

        return ApiResponse::success(
            data: new ServiceManagementResource($salon)
        );
    }

    //update
    public function update(ServiceManagementRequest $request, int $id)
    {
        $salon = $this->service->update($request->validated(), $id);

        return ApiResponse::success(
            data: new ServiceManagementResource($salon)
        );
    }

    public function delete($id)
    {
        $this->service->deleteById($id);

        return ApiResponse::success(
            message: "Service deleted successfully",
        );
    }

    // Menampilkan data berdasarkan ID
    public function readById($id)
    {
        $response = $this->service->getById($id);

        $resource = new ServiceManagementResource($response);

        return ApiResponse::success(
            data: $resource,
        );
    }

    public function getPaginatedBySalonId(int $salonId,  Request $request)
    {
        $response = $this->service->getPaginatedBySalonId($salonId, $request);

        if ($response->isEmpty()) {
            return response()->json([
                'data' => [],
                'message' => 'No Service Management found',
            ], 200);
        }

        return ServiceManagementResource::collection($response);
    }
}
