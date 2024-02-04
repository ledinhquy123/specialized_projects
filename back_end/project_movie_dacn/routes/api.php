<?php

use App\Http\Controllers\api\UserController;
use App\Http\Controllers\api\MovieController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('movies/')->name('movies.')->group(function() {
    
    Route::get('getAllGenres', [MovieController::class, 'getAllGenres'])->name('get-all-genres');

    // Get now playing
    Route::get('getNowPlaying', [MovieController::class, 'getNowPlaying'])->name('get-now-playing');

    // Get popular
    Route::get('getPopular', [MovieController::class, 'getPopular'])->name('get-popular');

    // Get upComing
    Route::get('getUpcoming', [MovieController::class, 'getUpcoming'])->name('get-upcoming');

    // Get trendingDay
    Route::get('getTrendingDay', [MovieController::class, 'getTrendingDay'])->name('get-treding-day');

    // Get trendingWeek
    Route::get('getTrendingWeek', [MovieController::class, 'getTrendingWeek'])->name('get-treding-week');

    //  Get movieSearch
    Route::get('getSearchMovie', [MovieController::class, 'getSearchMovie'])->name('get-search-movie');

    Route::get('getActor/{idMovie}', [MovieController::class, 'getActor'])->name('get-actor');


    // Get weekdays
    Route::get('getWeekday', [MovieController::class, 'getWeekday'])->name('get-week-day');

    Route::get('getShowtime/{id}', [MovieController::class, 'getShowtime'])->name('get-show-time');

});

Route::prefix('users/')->name('users.')->group(function() {
    Route::get('/', [UserController::class, 'index'])->name('list');

    Route::post('create', [UserController::class, 'create'])->name('create');

    Route::post('login', [UserController::class, 'login'])->name('login');

    Route::post('verify-email/{email}', [UserController::class, 'verifyEmail'])->name('verify-email');

    Route::put('change-pass', [UserController::class, 'changePass'])->name('change-pass');

});