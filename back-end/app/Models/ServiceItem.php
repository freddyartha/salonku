<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServiceItem extends Model
{
    use HasFactory;

    protected $table = 'tr_service_item';

    protected $fillable = [
        'id_service_management',
        'nama_service',
        'deskripsi',
        'harga',
    ];

    public function serviceManagement()
    {
        return $this->belongsTo(ServiceManagement::class, 'id_service_management');
    }
}
