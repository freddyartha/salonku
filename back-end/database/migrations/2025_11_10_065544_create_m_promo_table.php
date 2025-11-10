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
        Schema::create('m_promo', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_salon')->constrained('m_salon')->onDelete('cascade');
            $table->string('nama');
            $table->string('deskripsi')->nullable();
            $table->decimal('potongan_harga', 15, 2)->nullable();
            $table->decimal('potongan_persen', 15, 2)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_promo');
    }
};
