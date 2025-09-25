<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductManagement extends Model
{
    use HasFactory;

    protected $table = 'tr_product_management';

    protected $fillable = [
        'id_product',
        'id_payment_method',
        'is_masuk',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class, 'id_product');
    }

    public function paymentMethod()
    {
        return $this->belongsTo(PaymentMethod::class, 'id_payment_method');
    }
}
