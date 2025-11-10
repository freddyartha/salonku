<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PromoResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'        => $this->id,
            'id_salon'  => $this->id_salon,
            'nama'      => $this->nama,
            'deskripsi'          => $this->deskripsi,
            'potongan_harga'     => $this->potongan_harga,
            'potongan_persen'    => $this->potongan_persen,
        ];
    }
}
