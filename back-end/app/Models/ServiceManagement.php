<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ServiceManagement extends Model
{
    protected $table = 'tr_service_management';

    protected $fillable = [
        'id_client',
        'id_payment_method',
        'id_service',
        'id_salon',
        'id_cabang',
        'catatan',
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

    public function services()
    {
        return $this->belongsToMany(
            Service::class,
            'tr_id_service_management', // nama tabel pivot
            'id_service_management',    // foreign key ke ServiceManagement
            'id_service'                // foreign key ke Service
        )->withTimestamps();
    }

    public function promos()
    {
        return $this->belongsToMany(
            Promo::class,
            'tr_service_promo', // nama tabel pivot
            'id_service_management',    // foreign key ke ServiceManagement
            'id_promo'                // foreign key ke Service
        )->withTimestamps();
    }

    public function salon()
    {
        return $this->belongsTo(Salon::class, 'id_salon');
    }

    public function cabang()
    {
        return $this->belongsTo(SalonCabang::class, 'id_cabang');
    }

    public function serviceItems()
    {
        return $this->hasMany(ServiceItem::class, 'id_service_management');
    }


    protected static function booted()
    {
        static::deleting(function ($management) {
            $management->serviceItems()->delete();
        });
    }
}
