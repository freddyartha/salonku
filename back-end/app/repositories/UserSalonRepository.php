<?php

namespace App\Repositories;

use App\Models\UserSalon;

class UserSalonRepository
{
    public function findByFirebaseId(string $firebaseId)
    {
        return UserSalon::where("id_user_firebase", $firebaseId)->first();
    }

    // public function create(array $data): Salon
    // {
    //     return Salon::create($data);
    // }

    // public function update(array $data, $id): Salon
    // {
    //     $salon = $this->findById($id);
    //     $salon->update($data);

    //     return $salon;
    // }
}
