<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Showtime extends Model
{
    use HasFactory;
    protected $table = 'showtimes';

    public function screens() {
        return $this->belongsTo( 
            Screen::class, 'screen_id', 'id'
        );
    }

    public function movies() {
        return $this->belongsTo(
            Movie::class, 'id_movie', 'id_movie'
        );
    }

    public function weekdays() {
        return $this->belongsTo(
            Weekday::class, 'weekday_id', 'id'
        );
    }

    public function timeframes() {
        return $this->belongsTo(
            Timeframe::class, 'timeframe_id', 'id'
        );
    }
}
