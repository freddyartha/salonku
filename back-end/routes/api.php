<?php

use App\Http\Controllers\SalonController;
use Illuminate\Support\Facades\Route;

Route::get('/salon/{id}', [SalonController::class, 'readSalonById']);
Route::post('/salon', [SalonController::class, 'storeSalon']);
Route::put('/salon/{id}', [SalonController::class, 'updateSalon']);
