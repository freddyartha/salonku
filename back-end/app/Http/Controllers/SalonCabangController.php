<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
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
