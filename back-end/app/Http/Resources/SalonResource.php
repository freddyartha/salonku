<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SalonResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'         => $this->id,
            'nama_salon' => $this->nama_salon,
            'kode_salon' => $this->kode_salon,
            'alamat'     => $this->alamat,
            'phone'      => $this->phone,
            'logo_url'   => $this->logo_url,
        ];
    }
}
