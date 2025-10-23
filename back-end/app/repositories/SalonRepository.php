<?php

namespace App\Repositories;

use App\Models\Salon;

class SalonRepository
{
    public function findById(int $id)
    {
        return Salon::with('cabang')->find($id);
    }

    public function findByUniqueId(string $uniqueId)
    {
        return Salon::where('kode_salon', $uniqueId)->firstOrFail();
    }

    public function create(array $data): Salon
    {
        return Salon::create($data);
    }

    public function update(array $data, $id): Salon
    {
        $salon = $this->findById($id);
        $salon->update($data);

        return $salon;
    }

    public function getJumlahCabang($id): int
    {
        $salon = Salon::withCount('cabang')->find($id);

        if (!$salon) {
            return 0;
        }

        return $salon->cabang_count;
    }
}
