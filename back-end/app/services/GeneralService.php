<?php

namespace App\Services;

use App\Repositories\GeneralRepository;
use App\Repositories\SalonRepository;
use App\Repositories\UserSalonRepository;

class GeneralService
{
    protected $generalRepository;
    protected $salonRepository;
    protected $userSalonRepository;

    public function __construct(GeneralRepository $generalRepository,   SalonRepository $salonRepository, UserSalonRepository $userSalonRepository)
    {
        $this->generalRepository = $generalRepository;
        $this->salonRepository = $salonRepository;
        $this->userSalonRepository = $userSalonRepository;
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
}
