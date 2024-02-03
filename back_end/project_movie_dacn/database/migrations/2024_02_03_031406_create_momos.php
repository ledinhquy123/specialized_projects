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
        Schema::create('momos', function (Blueprint $table) {
            $table->increments('id');            
            $table->string('transaction_id');

            $table->string('partner_code')->nullable();
            $table->string('order_id')->nullable();
            $table->string('request_id')->nullable();
            $table->string('amount')->nullable();
            $table->string('order_info')->nullable();
            $table->string('order_type')->nullable();
            $table->string('pay_type')->nullable();
            $table->string('signature')->nullable();
            $table->integer('transaction_type_id')->unsigned();

            $table->foreign('transaction_type_id')->references('id')->on('transactions_type');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('momos');
    }
};
