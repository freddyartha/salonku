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
        Schema::create('m_service_cabang', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_service')->constrained('m_service')->onDelete('cascade');
            $table->foreignId('id_cabang')->constrained('m_salon_cabang')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_service_cabang');
    }
};
