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
        Schema::create('tr_service_management', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_client')->constrained('m_client')->onDelete('cascade');
            $table->foreignId('id_payment_method')->constrained('m_payment_method')->onDelete('cascade');
            $table->foreignId('id_service')->constrained('m_service')->onDelete('cascade')->allowNull();
            $table->foreignId('id_salon')->constrained('m_salon')->onDelete('cascade')->allowNull();
            $table->foreignId('id_cabang')->constrained('m_salon_cabang')->onDelete('cascade')->allowNull();
            $table->string('nama');
            $table->text('deskripsi')->nullable();
            $table->decimal('harga', 15, 2)->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tr_service_management');
    }
};
