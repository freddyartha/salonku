<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BookingResource extends JsonResource
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
            'client' => $this->whenLoaded('client', function () {
                return [
                    'id' => $this->client->id,
                    'nama' => $this->client->nama ?? '',
                    'phone' => $this->client->phone,
                    'email' => $this->client->email,
                ];
            }),
            'tanggal_jam'   => $this->tanggal_jam,
            'catatan'       => $this->catatan,
        ];
    }
}
