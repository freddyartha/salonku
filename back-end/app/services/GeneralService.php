<?php

namespace App\Services;

use App\Repositories\GeneralRepository;
use App\Repositories\PengeluaranRepository;
use App\Repositories\SalonRepository;
use App\Repositories\ServiceManagementRepository;
use App\Repositories\UserSalonRepository;

class GeneralService
{
    protected $generalRepository;
    protected $salonRepository;
    protected $userSalonRepository;
    protected $serviceManagementRepository;
    protected $pengeluaranRepository;

    public function __construct(
        GeneralRepository $generalRepository,
        SalonRepository $salonRepository,
        UserSalonRepository $userSalonRepository,
        ServiceManagementRepository $serviceManagementRepository,
        PengeluaranRepository $pengeluaranRepository
    ) {
        $this->generalRepository = $generalRepository;
        $this->salonRepository = $salonRepository;
        $this->userSalonRepository = $userSalonRepository;
        $this->serviceManagementRepository = $serviceManagementRepository;
        $this->pengeluaranRepository = $pengeluaranRepository;
    }

    public function getSalonSummary(int $id)
    {
        $jumlahCabang = $this->salonRepository->getJumlahCabang($id);
        $jumlahStaff = $this->userSalonRepository->getJumlahStaff($id);

        return [
            'jumlah_cabang' => $jumlahCabang,
            'jumlah_staff' => $jumlahStaff,
            'jumlah_client' => "",
            'pemasukan_hari_ini' => "",
            'pengeluaran_hari_ini' => "",
        ];
    }


    public function getIncomeExpenseWithPeriod($idSalon, $idCabang, $fromDate, $toDate)
    {
        $getTotalIncome = $this->serviceManagementRepository->readWithPeriod($idSalon, $idCabang, $fromDate, $toDate);
        $getTotalExpense = $this->pengeluaranRepository->readWithPeriod($idSalon, $idCabang, $fromDate, $toDate);

        return [
            'total_income' => $getTotalIncome,
            'total_expense' => $getTotalExpense,
        ];
    }
}
