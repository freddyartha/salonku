<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Supplier extends Model
{
    use HasFactory;

    protected $table = 'm_supplier';

    protected $fillable = [
        'id_salon',
        'nama',
        'alamat',
        'phone',
    ];

    /**
     * Relasi ke Salon
     */
    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }

     public function products()
    {
        return $this->belongsToMany(Product::class, 'm_supplier_product', 'id_supplier', 'id_product');
    }

}
