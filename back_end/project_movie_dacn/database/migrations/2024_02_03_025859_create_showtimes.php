<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('showtimes', function (Blueprint $table) {
            $table->increments('id');

            $table->integer('screen_id')->unsigned();
            $table->string('id_movie');
            $table->integer('weekday_id')->unsigned();
            $table->integer('timeframe_id')->unsigned();
            $table->timestamps();

            $table->foreign('id_movie')->references('id_movie')->on('movies');
            $table->foreign('weekday_id')->references('id')->on('weekdays');
            $table->foreign('timeframe_id')->references('id')->on('timeframes');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('showtimes');
    }
};
