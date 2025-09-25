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
        Schema::create('m_user_cabang', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_user')->constrained('m_user')->onDelete('cascade');
            $table->foreignId('id_cabang')->constrained('m_salon_cabang')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tr_user_cabang');
    }
};
