<?php

namespace App\Http\Controllers;

use App\Services\UserSalonService;
use App\Helpers\ApiResponse;
use App\Http\Requests\UserSalonRequest;
use App\Http\Resources\UserSalonResource;
use App\Models\User;
use App\Models\UserSalon;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;

class UserSalonController extends Controller
{
    protected $userSalonService;

    public function __construct(UserSalonService $userSalonService)
    {
        $this->userSalonService = $userSalonService;
    }

    // Mencari user salon by firebase id
    public function readUserSalonByFirebaseId($id)
    {
        $response = $this->userSalonService->getUserSalonByFirebaseId($id);

        return ApiResponse::success(
            data: new UserSalonResource($response),
        );
    }

    public function registerNewUser(UserSalonRequest $request)
    {
        $response = $this->userSalonService->register($request->validated());

        return ApiResponse::success(
            data: new UserSalonResource($response),
        );
    }

    //Add id_salon for user level staff
    public function userAddSalon(Request $request, $id)
    {
        $request->validate([
            'id_salon' => 'required|integer|exists:m_salon,id',
        ]);

        $response = $this->userSalonService->userAddSalon($request->id_salon, $id);

        return ApiResponse::success(
            data: new UserSalonResource($response),
        );
    }

    public function userRemoveSalon($id)
    {
        $response = $this->userSalonService->userRemoveSalon($id);

        return ApiResponse::success(
            data: new UserSalonResource($response),
        );
    }
}
