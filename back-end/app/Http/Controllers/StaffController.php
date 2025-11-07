<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\StaffRequest;
use App\Http\Resources\UserSalonResource;
use App\Services\StaffService;
use Illuminate\Http\Request;

class StaffController extends Controller
{
    protected $service;

    public function __construct(StaffService $service)
    {
        $this->service = $service;
    }

    //update
    public function update(StaffRequest $request, int $id)
    {
        $salon = $this->service->update($request->validated(), $id);

        return ApiResponse::success(
            data: new UserSalonResource($salon)
        );
    }

    public function deactivateStaff($id)
    {
        $this->service->deactivateStaff($id);

        return ApiResponse::success(
            message: "staff deactivated successfully",
        );
    }

    public function demoteStaff($id)
    {
        $response =  $this->service->promoteStaff($id, false);

        $resource = new UserSalonResource($response);

        return ApiResponse::success(
            data: $resource,
        );
    }

    public function promoteStaff($id)
    {
        $response =  $this->service->promoteStaff($id, true);

        $resource = new UserSalonResource($response);

        return ApiResponse::success(
            data: $resource,
        );
    }

    // Menampilkan data berdasarkan ID
    public function readById($id)
    {
        $response = $this->service->getById($id);

        $resource = new UserSalonResource($response);

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
                'message' => 'No staff found',
            ], 200);
        }

        return UserSalonResource::collection($response);
    }
}
