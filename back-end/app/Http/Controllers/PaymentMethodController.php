<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\PaymentMethodRequest;
use App\Http\Resources\PaymentMethodResource;
use App\Services\PaymentMethodService;
use Illuminate\Http\Request;

class PaymentMethodController extends Controller
{
    protected $service;

    public function __construct(PaymentMethodService $service)
    {
        $this->service = $service;
    }

    //create
    public function store(PaymentMethodRequest $request)
    {
        $salon = $this->service->store($request->validated());

        return ApiResponse::success(
            data: new PaymentMethodResource($salon)
        );
    }

    //create
    public function update(PaymentMethodRequest $request, int $id)
    {
        $salon = $this->service->update($request->validated(), $id);

        return ApiResponse::success(
            data: new PaymentMethodResource($salon)
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

        $resource = new PaymentMethodResource($response);

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

        return PaymentMethodResource::collection($response);
    }
}
