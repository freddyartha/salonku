<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\SalonCabangRequest;
use App\Http\Resources\SalonCabangResource;
use App\Services\SalonCabangService;
use Illuminate\Http\Request;

class SalonCabangController extends Controller
{
    protected $salonCabangService;

    public function __construct(SalonCabangService $salonCabangService)
    {
        $this->salonCabangService = $salonCabangService;
    }

    //create
    public function storeCabang(SalonCabangRequest $request)
    {
        $salon = $this->salonCabangService->store($request->validated());

        return ApiResponse::success(
            data: new SalonCabangResource($salon)
        );
    }

    //create
    public function updateCabang(SalonCabangRequest $request, int $id)
    {
        $salon = $this->salonCabangService->update($request->validated(), $id);

        return ApiResponse::success(
            data: new SalonCabangResource($salon)
        );
    }

    public function deleteCabang($id)
    {
        $this->salonCabangService->deleteById($id);

        return ApiResponse::success(
            message: "Service deleted successfully",
        );
    }

    // Menampilkan data berdasarkan ID
    public function readCabangById($id)
    {
        $response = $this->salonCabangService->getSalonById($id);

        $resource = new SalonCabangResource($response);

        return ApiResponse::success(
            data: $resource,
        );
    }

    public function getPaginatedCabangBySalonId(int $salonId,  Request $request)
    {
        $response = $this->salonCabangService->getPaginatedCabangBySalonId($salonId, $request);

        if ($response->isEmpty()) {
            return response()->json([
                'data' => [],
                'message' => 'No cabang found',
            ], 200);
        }

        return SalonCabangResource::collection($response);
    }
}
