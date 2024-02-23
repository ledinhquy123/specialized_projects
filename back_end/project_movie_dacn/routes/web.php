<?php

use App\Http\Controllers\Auth\SocialController;
use Illuminate\Support\Facades\Route;
use Laravel\Socialite\Facades\Socialite;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::prefix('auth/')->name('auth.')->group(function() {
    Route::get('google', [SocialController::class, 'googleLogin'])->name('google-login');

    Route::get('google/callback', [SocialController::class, 'googleCallback'])->name('google-callback');
});