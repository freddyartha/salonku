<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use App\Http\Resources\ListTransaksiResource;
use App\Models\ServiceManagement;
use App\Services\GeneralService;
use Barryvdh\DomPDF\Facade\Pdf as FacadePdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

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
        $request->merge($request->query());
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

    public function generateTransaksiReportPdf(int $salonId, Request $request)
    {
        $from_date = $request->query('from_date');
        $to_date =  $request->query('to_date');

        $response = $this->generalService->getPemasukanPengeluaranReport($salonId, $request);
        $pemasukanIds = $response
            ->where('type', 'Pemasukan')
            ->pluck('id')
            ->toArray();

        $serviceData = ServiceManagement::whereIn('id', $pemasukanIds)
            ->get()
            ->keyBy('id'); // index by ID

        $response->transform(function ($item) use ($serviceData) {
            if (strtolower($item->type ?? '') === 'pemasukan') {
                $item->nominal = $serviceData[$item->id]->total_final ?? 0;
            }
            return $item;
        });

        $items = [];
        $no = 1;

        foreach ($response as $row) {
            $items[] = [
                'no'         => $no++,
                'id'         => $row->id,
                'created_at' => $row->created_at,
                'nominal'    => $row->nominal,
                'keterangan' => $row->keterangan,
                'type'       => $row->type,
            ];
        }

        // ubah associative array menjadi numeric array
        $items = array_values($items);

        // Data laporan
        $data = [
            'title' => 'Laporan Transaksi',
            'from_date' => Carbon::parse($from_date)->translatedFormat('d F Y'),
            'to_date' => Carbon::parse($to_date)->translatedFormat('d F Y'),
            'items' => $items,
        ];

        // Render PDF dengan blade
        $pdf = FacadePdf::loadView('pdf.laporan', $data)->setPaper('A4');

        $filename = 'laporan-' . $from_date . '-' . $to_date . '.pdf';

        // Simpan ke storage public
        Storage::disk('public')->put('pdf/' . $filename, $pdf->output());


        $url = asset('storage/pdf/' . $filename);

        return ApiResponse::success(
            data: $url,
        );
    }

    // public function getIncomeExpenseWithPeriod($id)
    // {
    //     $response = $this->generalService->getIncomeExpenseWithPeriod($id);

    //     return ApiResponse::success(
    //         data: $response,
    //     );
    // }
}
