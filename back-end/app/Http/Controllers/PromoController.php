<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\PromoRequest;
use App\Http\Resources\PromoResource;
use App\Services\PromoService;
use Illuminate\Http\Request;

class PromoController extends Controller
{
    protected $service;

    public function __construct(PromoService $service)
    {
        $this->service = $service;
    }

    //create
    public function store(PromoRequest $request)
    {
        $salon = $this->service->store($request->validated());

        return ApiResponse::success(
            data: new PromoResource($salon)
        );
    }

    //create
    public function update(PromoRequest $request, int $id)
    {
        $salon = $this->service->update($request->validated(), $id);

        return ApiResponse::success(
            data: new PromoResource($salon)
        );
    }

    public function delete($id)
    {
        $this->service->deleteById($id);

        return ApiResponse::success(
            message: "Promo deleted successfully",
        );
    }

    // Menampilkan data berdasarkan ID
    public function readById($id)
    {
        $response = $this->service->getById($id);

        $resource = new PromoResource($response);

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
                'message' => 'No promo found',
            ], 200);
        }

        return PromoResource::collection($response);
    }
}
