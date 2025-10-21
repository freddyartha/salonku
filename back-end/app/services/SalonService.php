<?php

namespace App\Services;

use App\Repositories\SalonRepository;

class SalonService
{
    protected $salonRepository;

    public function __construct(SalonRepository $salonRepository)
    {
        $this->salonRepository = $salonRepository;
    }

    public function getSalonById(int $id)
    {
        return $this->salonRepository->findById($id);
    }

    public function getSalonByUniqueId(string $uniqueId)
    {
        return $this->salonRepository->findByUniqueId($uniqueId);
    }



    public function store(array $data)
    {
        $data['kode_salon'] = $this->generateUniqueCode();

        return $this->salonRepository->create($data);
    }

    public function update(array $data, int $id)
    {
        return $this->salonRepository->update($data, $id);
    }

    private function generateUniqueCode()
    {
        $prefix = 'SL';
        $datePart = now()->format('Ymd');
        $millis = (int) (microtime(true) * 1000);
        $lastDigits = substr($millis, -6);
        $random = mt_rand(10, 99);

        return "{$prefix}-{$datePart}-{$lastDigits}{$random}";
    }
}
