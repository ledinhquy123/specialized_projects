<?php

use App\Http\Controllers\api\UserController;
use App\Http\Controllers\api\MovieController;
use App\Http\Controllers\api\QrCodeController;
use App\Http\Controllers\api\TransactionController;
use App\Http\Controllers\Auth\SocialController;
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

Route::prefix('qrcodes/')->name('qrcodes.')->group(function() {
    Route::get('create-qrcode-ticket/{id}', [QrCodeController::class, 'createQrCodeTicket'])->name('create-ticket');
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

    // Follow weekdayId
    Route::get('getShowtime/{id}', [MovieController::class, 'getShowtime'])->name('get-show-time');

    Route::get('getShowtimeMovieId/{idWeekday}/{idMovie}', [MovieController::class, 'getShowtimeIdMovie'])->name('get-show-time-idmovie');

    // Get seats follow screenId
    Route::get('getSeats/{screenId}/{showtimeId}', [MovieController::class, 'getSeats'])->name('get-seat');

    // Get bill
    Route::post('getBill', [MovieController::class, 'getBill'])->name('get-bill');

    // Reservations
    Route::post('reservations', [MovieController::class, 'reservations'])->name('reservations');

    Route::get('get-movie-comments/{idMovie}', [MovieController::class, 'getMovieComments'])->name('get-movie-comments');

    Route::post('create-movie-comment', [MovieController::class, 'createMovieComment'])->name('create-movie-comment');

    Route::post('check-user-comment', [MovieController::class, 'checkUserComment'])->name('check-user-comment');
});

Route::prefix('transactions/')->name('transactions.')->group(function() {
    Route::get('/', [TransactionController::class, 'index'])->name('list');

    Route::post('createTicket', [TransactionController::class, 'createTicket'])->name('create-ticket');

    Route::get('get-all-tickets', [TransactionController::class, 'getAllTickets'])->name('get-all-tickets');

    // Follow userId
    Route::get('get-ticket/{userId}', [TransactionController::class, 'getTicketFollowUser'])->name('get-ticket-follow-user');
});

Route::prefix('users/')->name('users.')->group(function() {
    Route::get('/', [UserController::class, 'index'])->name('list');

    Route::post('create', [UserController::class, 'create'])->name('create');

    Route::post('update', [UserController::class, 'update'])->name('update');

    Route::post('check-email-update', [UserController::class, 'checkEmailUpdate'])->name('check-email-update');

    Route::post('login', [UserController::class, 'login'])->name('login');

    Route::post('verify-email/{email}', [UserController::class, 'verifyEmail'])->name('verify-email');

    Route::put('change-pass', [UserController::class, 'changePass'])->name('change-pass');
});

Route::prefix('social/')->name('social.')->group(function() {
    Route::post('login-google', [SocialController::class, 'appGoogleSignIn'])->name('app-login-google');
});
