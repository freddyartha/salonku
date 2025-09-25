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
        Schema::create('tr_product_management', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_product')->constrained('m_product')->onDelete('cascade');
            $table->foreignId('id_payment_method')->constrained('m_payment_method')->onDelete('cascade');
            $table->boolean('is_masuk'); // true = masuk, false = keluar
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tr_product_management');
    }
};
