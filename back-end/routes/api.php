<?php

use App\Http\Controllers\FirebaseAuthController;
use App\Http\Controllers\SalonController;
use App\Http\Controllers\UserSalonController;
use Illuminate\Support\Facades\Route;

Route::post('/test-login', [FirebaseAuthController::class, 'login']);
Route::post('/user-register', [UserSalonController::class, 'registerNewUser']);

Route::middleware('firebase.auth')->group(function () {
    Route::get('/salon/{id}', [SalonController::class, 'readSalonById']);
    Route::post('/salon', [SalonController::class, 'storeSalon']);
    Route::put('/salon/{id}', [SalonController::class, 'updateSalon']);

    //User Salon
    Route::get('/user-salon/{id}', [UserSalonController::class, 'readUserSalonByFirebaseId']);
});
