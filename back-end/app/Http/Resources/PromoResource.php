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
            'currency_code' => $this->whenLoaded('salon', function () {
                return $this->salon->currency_code;
            }),
            'nama'      => $this->nama,
            'deskripsi'          => $this->deskripsi,
            'potongan_harga'     => $this->potongan_harga,
            'potongan_persen'    => $this->potongan_persen,
            'berlaku_mulai'    => $this->berlaku_mulai,
            'berlaku_sampai'    => $this->berlaku_sampai,
        ];
    }
}
