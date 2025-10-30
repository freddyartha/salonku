<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'            => $this->id,
            'id_salon'      => $this->id_salon,
            'id_supplier'   => $this->id_supplier,
            'brand'         => $this->brand,
            'nama'          => $this->nama,
            'ukuran'        => $this->ukuran,
            'satuan'        => $this->satuan,
            'harga_satuan'  => $this->harga_satuan,
            'currency_code' => $this->whenLoaded('salon', function () {
                return $this->salon ? $this->salon->currency_code : null;
            }),
        ];
    }
}
