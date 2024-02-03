<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Showtime extends Model
{
    use HasFactory;
    protected $table = 'showtimes';

    public function screens() {
        return $this->hasMany( 
            Screen::class, 'id', 'screen_id'
        );
    }

    public function movies() {
        return $this->hasMany(
            Movie::class, 'id_movie', 'id_movie'
        );
    }

    public function weekdays() {
        return $this->hasMany(
            Weekday::class, 'id','weekday_id'
        );
    }

    public function timeframes() {
        return $this->hasMany(
            Timeframe::class, 'id', 'timeframe_id'
        );
    }
}
