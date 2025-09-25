<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $table = 'm_product';

    protected $fillable = [
        'id_salon',
        'id_supplier',
        'brand',
        'nama',
        'ukuran',
        'satuan',
        'harga_satuan',
    ];

    /**
     * Relasi ke Salon
     */
    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }

    /**
     * Relasi ke Supplier
     */
    public function suppliers()
    {
        return $this->belongsToMany(Supplier::class, 'm_supplier_product', 'id_product', 'id_supplier');
    }
}
