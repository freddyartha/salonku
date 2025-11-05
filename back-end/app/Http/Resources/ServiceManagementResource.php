<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ServiceManagementResource extends JsonResource
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
            'id_client'         => $this->id_client,
            'id_payment_method' => $this->id_payment_method,
            'id_salon'          => $this->id_salon,
            'id_cabang'         => $this->id_cabang,
            'catatan'           => $this->catatan,

            // Relasi (hanya jika sudah di-load menggunakan with())
            'salon' => $this->whenLoaded('salon', function () {
                return [
                    'id'            => $this->salon->id,
                    'nama_salon'    => $this->salon->nama_salon,
                    'kode_salon'    => $this->salon->kode_salon,
                    'currency_code' => $this->salon->currency_code,
                    'alamat'        => $this->salon->alamat,
                    'phone'         => $this->salon->phone,
                    'logo_url'      => $this->salon->logo_url,
                    'cabang'        => $this->salon->cabang,
                ];
            }),
            'client' => $this->whenLoaded('client', function () {
                return [
                    'id'            => $this->client->id,
                    'id_salon'      => $this->client->id_salon,
                    'nama'          => $this->client->nama,
                    'jenis_kelamin' => $this->client->jenis_kelamin,
                    'alamat'        => $this->client->alamat,
                    'email'         => $this->client->email,
                    'phone'         => $this->client->phone,
                ];
            }),

            'payment_method' => $this->whenLoaded('paymentMethod', function () {
                return [
                    'id'     => $this->paymentMethod->id,
                    'id_salon'  => $this->paymentMethod->id_salon,
                    'nama'   => $this->paymentMethod->nama,
                    'kode'   => $this->paymentMethod->kode ?? null,
                ];
            }),

            'services' => $this->whenLoaded('services', function () {
                return $this->services->map(function ($item) {
                    return [
                        'id'        => $item->id,
                        'id_salon'  => $item->id_salon,
                        'nama'      => $item->nama,
                        'deskripsi' => $item->deskripsi,
                        'harga'     => $item->harga,
                    ];
                });
            }),

            'cabang' => $this->whenLoaded('cabang', function () {
                return [
                    'id'      => $this->cabang->id,
                    'id_salon'  => $this->cabang->id_salon,
                    'nama'    => $this->cabang->nama,
                    'alamat'  => $this->cabang->alamat,
                    'phone'   => $this->cabang->phone,
                ];
            }),

            'service_items' => $this->whenLoaded('serviceItems', function () {
                return $this->serviceItems->map(function ($item) {
                    return [
                        'id'                      => $item->id,
                        'id_service_management'   => $item->id_service_management,
                        'nama_service'            => $item->nama_service,
                        'harga'                   => $item->harga,
                        'deskripsi'               => $item->deskripsi ?? null,
                    ];
                });
            }),
        ];
    }
}
