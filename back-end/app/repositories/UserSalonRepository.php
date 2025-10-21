<?php

namespace App\Repositories;

use App\Models\UserSalon;
use App\Repositories\Request;

class UserSalonRepository
{
    public function findByFirebaseId(string $firebaseId)
    {
        return UserSalon::where("id_user_firebase", $firebaseId)->first();
    }

    public function register(array $data): UserSalon
    {
        return UserSalon::create($data);
    }

    public function userAddSalon(int $idSalon, $id)
    {
        $user = UserSalon::findOrFail($id);
        $user->update([
            'id_salon' => $idSalon,
        ]);
        return $user->fresh();
    }

    // public function update(array $data, $id): Salon
    // {
    //     $salon = $this->findById($id);
    //     $salon->update($data);

    //     return $salon;
    // }
}
