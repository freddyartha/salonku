<?php

namespace App\Services;

use App\Repositories\UserSalonRepository;

class UserSalonService
{
    protected $userSalonRepository;

    public function __construct(UserSalonRepository $userSalonRepository)
    {
        $this->userSalonRepository = $userSalonRepository;
    }

    public function getUserSalonByFirebaseId(string $firebaseId)
    {
        return $this->userSalonRepository->findByFirebaseId($firebaseId);
    }

    public function register(array $data)
    {
        return $this->userSalonRepository->register($data);
    }

    public function userAddSalon(int $idSalon, $id)
    {
        return $this->userSalonRepository->userAddSalon($idSalon, $id);
    }



    // public function update(array $data, int $id)
    // {
    //     return $this->userSalonRepository->update($data, $id);
    // }
}
