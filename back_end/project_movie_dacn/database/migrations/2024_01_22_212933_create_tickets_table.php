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
        Schema::create('tickets', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('movie_id')->unsigned();
            $table->integer('screen_id')->unsigned();
            $table->integer('seat_id')->unsigned();
            $table->integer('user_id')->unsigned();
            $table->double('total_price')->nullable();

            $table->timestamps();

            $table->foreign('movie_id')->references('id')->on('movies');
            $table->foreign('screen_id')->references('id')->on('screens');
            $table->foreign('seat_id')->references('id')->on('seats');
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tickets');
    }
};
