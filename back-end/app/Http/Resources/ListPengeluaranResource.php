<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ListPengeluaranResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        // return parent::toArray($request);
        return [
            'id'        => $this->id,
            'nama'      => $this->nama,
            'deskripsi' => $this->deskripsi,
            'harga'     => $this->harga,
            'currency_code' => $this->whenLoaded('salon', function () {
                return $this->salon ? $this->salon->currency_code : null;
            }),
        ];
    }
}
