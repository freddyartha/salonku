<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserSalon extends Model
{
    use HasFactory;

    // Nama tabel
    protected $table = 'm_user';

    // Kolom yang bisa diisi mass-assignment
    protected $fillable = [
        'id_salon',
        'owner_approval',
        'approved_date',
        'id_user_firebase',
        'level',
        'nama',
        'email',
        'phone',
        'nik',
        'jenis_kelamin',
        'tanggal_lahir',
        'alamat',
        'avatar_url',
    ];

    /**
     * Relasi ke Salon
     */
    public function cabangs()
    {
        return $this->belongsToMany(
            SalonCabang::class,
            'm_user_cabang',
            'id_user',
            'id_cabang'
        );
    }
}
