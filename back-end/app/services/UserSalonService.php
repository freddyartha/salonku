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

    // public function store(array $data)
    // {
    //     return $this->userSalonRepository->create($data);
    // }

    // public function update(array $data, int $id)
    // {
    //     return $this->userSalonRepository->update($data, $id);
    // }
}
