<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pengeluaran extends Model
{
    use HasFactory;

    protected $table = 'tr_pengeluaran';

    protected $fillable = [
        'id_salon',
        'nama',
        'deskripsi',
        'harga',
    ];

    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }

    public function cabangs()
    {
        return $this->belongsToMany(
            SalonCabang::class,
            'tr_pengeluaran_cabang',
            'id_pengeluaran',
            'id_cabang'
        )->withTimestamps();
    }
}
