<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserSalonResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'id_salon' => $this->id_salon,
            'owner_approval' => $this->owner_approval,
            'approved_date' => $this->approved_date,
            'aktif' => $this->aktif,
            'id_user_firebase' => $this->id_user_firebase,
            'level' => $this->level,
            'nama' => $this->nama,
            'email' => $this->email,
            'phone' => $this->phone,
            'nik' => $this->nik,
            'jenis_kelamin' => $this->jenis_kelamin,
            'tanggal_lahir' => $this->tanggal_lahir,
            'alamat' => $this->alamat,
            'avatar_url' => $this->avatar_url,
            'cabangs' => SalonCabangResource::collection($this->whenLoaded('cabangs')),
        ];
    }
}
