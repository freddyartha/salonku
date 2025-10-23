<?php

namespace App\Repositories;

use App\Models\UserSalon;
use App\Repositories\Request;

class UserSalonRepository
{
    public function getJumlahStaff($id): int
    {
        $staff = UserSalon::where([
            ['id_salon', '=', $id],
            ['level', '=', 2],
            ['aktif', '=', 1],
        ])->count();

        if (!$staff) {
            return 0;
        }

        return $staff;
    }

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

    public function userRemoveSalon($id)
    {
        $user = UserSalon::findOrFail($id);
        $user->update([
            'id_salon' => null,
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
