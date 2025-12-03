<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ListTransaksiResource extends JsonResource
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
            'nominal'       => $this->nominal,
            'keterangan'    => $this->keterangan,
            'type'          => $this->type,
            'created_at'    => $this->created_at,
        ];
    }
}
