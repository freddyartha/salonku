<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    protected $table = 'm_service';

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
            'm_service_cabang',
            'id_service',
            'id_cabang'
        )->withTimestamps();
    }

}
