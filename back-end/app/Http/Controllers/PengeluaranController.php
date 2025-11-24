<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\PengeluaranRequest;
use App\Http\Resources\ListPengeluaranResource;
use App\Http\Resources\PengeluaranResource;
use App\Services\PengeluaranService;
use Illuminate\Http\Request;

class PengeluaranController extends Controller
{
    protected $service;

    public function __construct(PengeluaranService $service)
    {
        $this->service = $service;
    }


    public function getPaginatedBySalonId(int $salonId,  Request $request)
    {
        $response = $this->service->getPaginatedBySalonId($salonId, $request);

        if ($response->isEmpty()) {
            return response()->json([
                'data' => [],
                'message' => 'No expense found',
            ], 200);
        }

        return ListPengeluaranResource::collection($response);
    }

    // Menampilkan data berdasarkan ID
    public function readById($id)
    {
        $response = $this->service->getById($id);

        $resource = new PengeluaranResource($response);

        return ApiResponse::success(
            data: $resource,
        );
    }

    public function delete($id)
    {
        $this->service->deleteById($id);

        return ApiResponse::success(
            message: "Expense deleted successfully",
        );
    }

    public function store(PengeluaranRequest $request)
    {
        $salon = $this->service->store($request->validated());

        return ApiResponse::success(
            data: new PengeluaranResource($salon)
        );
    }

    public function update(PengeluaranRequest $request, int $id)
    {
        $salon = $this->service->update($request->validated(), $id);

        return ApiResponse::success(
            data: new PengeluaranResource($salon)
        );
    }
}
