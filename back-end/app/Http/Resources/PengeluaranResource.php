<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PengeluaranResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'        => $this->id,
            'id_salon'  => $this->id_salon,
            'nama'      => $this->nama,
            'deskripsi' => $this->deskripsi,
            'harga'     => $this->harga,
            'currency_code' => $this->whenLoaded('salon', function () {
                return $this->salon ? $this->salon->currency_code : null;
            }),
            'cabang'    => $this->whenLoaded('cabangs', function () {
                return $this->cabangs->map(function ($cabang) {
                    return [
                        'id'     => $cabang->id,
                        'nama'   => $cabang->nama,
                        'alamat' => $cabang->alamat,
                        'phone'  => $cabang->phone,
                    ];
                });
            }),
        ];
    }
}
