<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Requests\ClientRequest;
use App\Http\Resources\ClientResource;
use App\Services\ClientService;
use Illuminate\Http\Request;

class ClientController extends Controller
{
    protected $service;

    public function __construct(ClientService $service)
    {
        $this->service = $service;
    }

    //create
    public function store(ClientRequest $request)
    {
        $salon = $this->service->store($request->validated());

        return ApiResponse::success(
            data: new ClientResource($salon)
        );
    }

    //create
    public function update(ClientRequest $request, int $id)
    {
        $salon = $this->service->update($request->validated(), $id);

        return ApiResponse::success(
            data: new ClientResource($salon)
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

        $resource = new ClientResource($response);

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
                'message' => 'No client found',
            ], 200);
        }

        return ClientResource::collection($response);
    }
}
