<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ListServiceManagementResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'                => $this->id,
            'catatan'           => $this->catatan,

            // Relasi (hanya jika sudah di-load menggunakan with())
            'currency_code' => $this->whenLoaded('salon', function () {
                return $this->salon->currency_code;
            }),

            'client' => $this->whenLoaded('client', function () {
                return $this->client->nama;
            }),

            'cabang' => $this->whenLoaded('cabang', function () {
                return $this->cabang->nama;
            }),

            'services' => $this->whenLoaded('services', function () {
                return $this->services->map(function ($item) {
                    return [
                        'id'        => $item->id,
                        'nama'      => $item->nama,
                        'harga'     => $item->harga,
                    ];
                });
            }),

            'service_items' => $this->whenLoaded('serviceItems', function () {
                return $this->serviceItems->map(function ($item) {
                    return [
                        'id'              => $item->id,
                        'nama'            => $item->nama_service,
                        'harga'           => $item->harga,
                    ];
                });
            }),


        ];
    }
}
