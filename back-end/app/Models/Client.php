<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Client extends Model
{
    use HasFactory;

    // Nama tabel
    protected $table = 'm_client';

    // Kolom yang bisa diisi mass-assignment
    protected $fillable = [
        'id_salon',
        'nama',
        'jenis_kelamin',
        'alamat',
        'email',
        'phone',
    ];

    /**
     * Relasi ke Salon
     */
    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }
}
