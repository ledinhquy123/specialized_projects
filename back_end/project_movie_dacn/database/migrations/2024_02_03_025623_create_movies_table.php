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
        Schema::create('movies', function (Blueprint $table) {
            $table->string('id_movie')->primary();

            $table->string('title')->nullable();
            $table->string('genres')->nullable();
            $table->longText('over_view')->nullable();
            $table->string('poster_path')->nullable();
            $table->string('backdrop_path')->nullable();
            $table->string('video_path')->nullable();
            $table->double('vote_count')->nullable();
            $table->double('vote_average')->nullable();
            $table->string('country')->nullable();
            $table->string('runtime')->nullable();
            $table->date('release_date')->nullable();

            $table->tinyInteger('status')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('movies');
    }
};
