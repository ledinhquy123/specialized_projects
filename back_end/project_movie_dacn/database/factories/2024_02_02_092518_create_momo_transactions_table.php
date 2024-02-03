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
        Schema::create('momo_transactions', function (Blueprint $table) {
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
            $table->integer('ticket_id')->unsigned();

            $table->foreign('ticket_id')->references('id')->on('tickets');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('momo_transactions');
    }
};
