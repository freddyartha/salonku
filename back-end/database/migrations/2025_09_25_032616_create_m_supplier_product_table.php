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
        Schema::create('m_supplier_product', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_supplier')->constrained('m_supplier')->onDelete('cascade');
            $table->foreignId('id_product')->constrained('m_product')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_supplier_product');
    }
};
