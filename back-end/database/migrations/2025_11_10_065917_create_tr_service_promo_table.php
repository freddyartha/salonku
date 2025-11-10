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
        Schema::create('tr_service_promo', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_service_management')->constrained('tr_service_management')->onDelete('cascade');
            $table->foreignId('id_promo')->constrained('m_promo')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tr_service_promo');
    }
};
