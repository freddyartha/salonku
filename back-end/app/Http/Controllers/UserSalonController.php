<?php

namespace App\Http\Controllers;

use App\Services\UserSalonService;
use App\Helpers\ApiResponse;
use App\Http\Resources\UserSalonResource;

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

        $resource = new UserSalonResource($response);

        return ApiResponse::success(
            data: $resource,
        );
    }
}
