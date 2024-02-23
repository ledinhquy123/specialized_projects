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
            $table->integer('user_id')->unsigned();
            $table->string('movie_id');
            $table->string('screen_name')->nullable();
            $table->string('seats_name')->nullable();
            $table->string('showdate')->nullable();
            $table->string('show_time')->nullable();
            $table->double('total_price')->nullable();
            $table->string('qr_path')->nullable();
            $table->integer('transaction_type_id')->unsigned();
            
            $table->timestamps();
            
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('movie_id')->references('id_movie')->on('movies');
            $table->foreign('transaction_type_id')->references('id')->on('transactions_type');
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
