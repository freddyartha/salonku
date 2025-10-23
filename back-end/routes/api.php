<?php

use App\Http\Controllers\FirebaseAuthController;
use App\Http\Controllers\GeneralController;
use App\Http\Controllers\SalonController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\UserSalonController;
use Illuminate\Support\Facades\Route;

Route::post('/test-login', [FirebaseAuthController::class, 'login']);
Route::post('/user-register', [UserSalonController::class, 'registerNewUser']);

Route::middleware('firebase.auth')->group(function () {
    Route::get('/salon/{id}', [SalonController::class, 'readSalonById']);
    Route::post('/salon', [SalonController::class, 'storeSalon']);
    Route::put('/salon/{id}', [SalonController::class, 'updateSalon']);
    Route::get('/salon/kode/{kodeSalon}', [SalonController::class, 'readSalonByUniqueId']);


    //User Salon
    Route::get('/user-salon/{id}', [UserSalonController::class, 'readUserSalonByFirebaseId']);
    Route::patch('/user-salon/{id}/add-salon', [UserSalonController::class, 'userAddSalon']);
    Route::patch('/user-salon/{id}/remove-salon', [UserSalonController::class, 'userRemoveSalon']);

    //General 
    Route::get('/general/salon-summary/{id}', [GeneralController::class, 'getSalonSummary']);

    //Service
    Route::get('/service/{salonId}/list', [ServiceController::class, 'getPaginatedService']);
});
