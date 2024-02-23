<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    use HasFactory;
    protected $table = 'tickets';

    public function movie() {
        return $this->belongsTo(
            Movie::class, 'movie_id', 'id_movie'
        );
    }

    public function user() {
        return $this->belongsTo(
            User::class, 'user_id', 'id'
        );
    }
}
