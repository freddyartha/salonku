<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentMethod extends Model
{
    use HasFactory;

    protected $table = 'm_payment_method';

    protected $fillable = [
        'id_salon',
        'nama',
        'kode',
    ];

    /**
     * Relasi ke Salon
     */
    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }
}
