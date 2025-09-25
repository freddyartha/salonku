<?php

namespace App\Repositories;

use App\Models\Salon;

class SalonRepository
{
    public function findById(int $id)
    {
        return Salon::find($id);
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
    
}
