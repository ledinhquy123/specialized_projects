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
        Schema::create('vnpays', function (Blueprint $table) {
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
            $table->integer('transaction_type_id')->unsigned();

            $table->foreign('transaction_type_id')->references('id')->on('transactions_type');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vnpays');
    }
};
