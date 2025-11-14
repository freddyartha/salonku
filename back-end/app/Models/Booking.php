<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Booking extends Model
{
    use HasFactory;

    protected $table = 'tr_booking';

    protected $fillable = [
        'id_client',
        'id_salon',
        'id_cabang',
        'id_user',
        'tanggal_jam',
        'catatan',
    ];

    protected $casts = [
        'tanggal_jam' => 'datetime',
    ];

    // Relasi ke client
    public function client()
    {
        return $this->belongsTo(Client::class, 'id_client');
    }

    // Relasi ke salon
    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }

    // Relasi ke cabang
    public function cabang()
    {
        return $this->belongsTo(SalonCabang::class, 'id_cabang');
    }

    // Relasi ke user yang membuat booking
    public function user()
    {
        return $this->belongsTo(User::class, 'id_user');
    }
}
