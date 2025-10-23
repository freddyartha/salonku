<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Services\GeneralService;

class GeneralController extends Controller
{
    protected $generalService;

    public function __construct(GeneralService $generalService)
    {
        $this->generalService = $generalService;
    }

    // Menampilkan data berdasarkan ID
    public function getSalonSummary($id)
    {
        $response = $this->generalService->getSalonSummary($id);

        return ApiResponse::success(
            data: $response,
        );
    }
}
