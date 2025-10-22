<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SalonCabang extends Model
{
    use HasFactory;

    // Nama tabel
    protected $table = 'm_salon_cabang';

    // Kolom yang bisa diisi mass-assignment
    protected $fillable = [
        'id_salon',
        'nama',
        'alamat',
        'phone',
    ];

    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon', 'id');
    }

    /**
     * Relasi ke Salon (cabang milik 1 salon)
     */
    public function users()
    {
        return $this->belongsToMany(
            UserSalon::class,
            'm_user_cabang',
            'id_cabang',
            'id_user'
        );
    }

    public function services()
    {
        return $this->belongsToMany(
            Service::class,
            'm_service_cabang',
            'id_cabang',
            'id_service'
        )->withTimestamps();
    }
}
