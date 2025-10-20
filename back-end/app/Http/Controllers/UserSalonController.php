<?php

namespace App\Http\Controllers;

use App\Services\UserSalonService;
use App\Helpers\ApiResponse;
use App\Http\Requests\UserSalonRequest;
use App\Http\Resources\UserSalonResource;
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
}
