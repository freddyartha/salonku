<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\ProductRequest;
use App\Http\Resources\ProductResource;
use App\Services\ProductService;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    protected $service;

    public function __construct(ProductService $service)
    {
        $this->service = $service;
    }

    //create
    public function store(ProductRequest $request)
    {
        $salon = $this->service->store($request->validated());

        return ApiResponse::success(
            data: new ProductResource($salon)
        );
    }

    //create
    public function update(ProductRequest $request, int $id)
    {
        $salon = $this->service->update($request->validated(), $id);

        return ApiResponse::success(
            data: new ProductResource($salon)
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

        $resource = new ProductResource($response);

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
                'message' => 'No product found',
            ], 200);
        }

        return ProductResource::collection($response);
    }
}
