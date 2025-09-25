<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Salon extends Model
{
    use HasFactory;

    // Nama tabel (jika tidak pakai konvensi jamak Laravel)
    protected $table = 'm_salon';

    // Kolom yang bisa diisi mass-assignment
    protected $fillable = [
        'nama_salon',
        'alamat',
        'phone',
        'logo_url',
    ];

    public function suppliers()
    {
        return $this->hasMany(Supplier::class, 'id_salon');
    }

    public function products()
    {
        return $this->hasMany(Product::class, 'id_salon');
    }

    public function paymentMethods()
    {
        return $this->hasMany(PaymentMethod::class, 'id_salon');
    }


}
