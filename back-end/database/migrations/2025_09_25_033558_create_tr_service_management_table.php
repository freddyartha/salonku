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
            $table->foreignId('id_service')->nullable()->constrained('m_service')->onDelete('cascade');
            $table->foreignId('id_salon')->nullable()->constrained('m_salon')->onDelete('cascade');
            $table->foreignId('id_cabang')->nullable()->constrained('m_salon_cabang')->onDelete('cascade');
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
