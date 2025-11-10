<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Promo extends Model
{
    use HasFactory;

    protected $table = 'm_promo';

    protected $fillable = [
        'id_salon',
        'nama',
        'deskripsi',
        'potongan_harga',
        'potongan_persen',
    ];

    // 🔗 Relasi ke Salon
    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }

    // 🔗 Relasi ke Cabang (melalui tabel pivot m_promo_cabang)
    public function cabangs()
    {
        return $this->belongsToMany(SalonCabang::class, 'm_promo_cabang', 'id_promo', 'id_cabang')
            ->withTimestamps();
    }

    // 🔗 Relasi ke Service (melalui tr_service_promo)
    public function serviceManagements()
    {
        return $this->belongsToMany(ServiceManagement::class, 'tr_service_promo', 'id_promo', 'id_service_management')
            ->withTimestamps();
    }
}
