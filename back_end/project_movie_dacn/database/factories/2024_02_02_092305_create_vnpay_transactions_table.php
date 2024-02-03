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
        Schema::create('vnpay_transactions', function (Blueprint $table) {
            $table->increments('id');
            $table->string('transaction_no');
            $table->string('amount')->nullable();
            $table->string('bank_code')->nullable();
            $table->string('bank_tran_no')->nullable();
            $table->string('card_type')->nullable();
            $table->string('order_info')->nullable();
            $table->string('pay_date')->nullable();
            $table->string('response_code')->nullable();
            $table->string('tmn_code')->nullable();
            $table->string('txn_ref')->nullable();
            $table->string('secure_hash')->nullable();
            $table->integer('ticket_id')->unsigned();

            $table->foreign('ticket_id')->references('id')->on('tickets');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vnpay_transactions');
    }
};
