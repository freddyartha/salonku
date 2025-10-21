<?php

namespace App\Http\Controllers;

use App\Services\SalonService;
use App\Helpers\ApiResponse;
use App\Http\Resources\SalonResource;
use App\Http\Requests\StoreSalonRequest;

class SalonController extends Controller
{
    protected $salonService;

    public function __construct(SalonService $salonService)
    {
        $this->salonService = $salonService;
    }

    // Menampilkan data berdasarkan ID
    public function readSalonById($id)
    {
        $response = $this->salonService->getSalonById($id);

        $resource = new SalonResource($response);

        return ApiResponse::success(
            data: $resource,
        );
    }

    // Menampilkan data berdasarkan ID
    public function readSalonByUniqueId($kodeSalon)
    {
        try {
            $response = $this->salonService->getSalonByUniqueId($kodeSalon);
            $resource = new SalonResource($response);

            return ApiResponse::success(
                data: $resource,
            );
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return ApiResponse::error(
                message: "data tidak ditemukan",
                statusCode: 404
            );
        }
    }

    //create salon
    public function storeSalon(StoreSalonRequest $request)
    {
        $salon = $this->salonService->store($request->validated());

        return ApiResponse::success(
            data: new SalonResource($salon)
        );
    }

    //create salon
    public function updateSalon(StoreSalonRequest $request, int $id)
    {
        $salon = $this->salonService->update($request->validated(), $id);

        return ApiResponse::success(
            data: new SalonResource($salon)
        );
    }
}
