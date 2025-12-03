<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Resources\ListTransaksiResource;
use App\Models\ServiceManagement;
use App\Services\GeneralService;
use Illuminate\Http\Request;

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

    public function getIncomeExpenseWithPeriod(Request $request, $salonId)
    {
        $request->validate([
            'id_cabang'   => 'nullable|integer|exists:m_salon_cabang,id',
            'from_date'  => 'required|date',
            'to_date'    => 'required|date|after_or_equal:from_date',

        ]);

        $response = $this->generalService->getIncomeExpenseWithPeriod(
            $salonId,
            $request->id_cabang,
            $request->from_date,
            $request->to_date
        );

        return ApiResponse::success(
            data: $response,
        );
    }

    public function getPemasukanPengeluaranPaginated(int $salonId,  Request $request)
    {
        $response = $this->generalService->getPemasukanPengeluaranPaginated($salonId, $request);

        if ($response->isEmpty()) {
            return response()->json([
                'data' => [],
                'message' => 'No data found',
            ], 200);
        }

        $response->getCollection()->transform(function ($row) {
            if (strtolower($row->type ?? '') === 'pemasukan') {
                $model = ServiceManagement::find($row->id);
                $row->nominal = $model->total_final;
            }

            return $row;
        });

        return ListTransaksiResource::collection($response);
    }

    // public function getIncomeExpenseWithPeriod($id)
    // {
    //     $response = $this->generalService->getIncomeExpenseWithPeriod($id);

    //     return ApiResponse::success(
    //         data: $response,
    //     );
    // }
}
