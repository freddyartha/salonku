<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TrServiceManagement extends Model
{
    protected $table = 'tr_service_management';

    protected $fillable = [
        'id_client',
        'id_payment_method',
        'id_service',
        'id_salon',
        'id_cabang',
        'nama',
        'deskripsi',
        'harga',
    ];

    // Relasi
    public function client()
    {
        return $this->belongsTo(Client::class, 'id_client');
    }

    public function paymentMethod()
    {
        return $this->belongsTo(PaymentMethod::class, 'id_payment_method');
    }

    public function service()
    {
        return $this->belongsTo(Service::class, 'id_service');
    }

    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }

    public function cabang()
    {
        return $this->belongsTo(SalonCabang::class, 'id_cabang');
    }
}
