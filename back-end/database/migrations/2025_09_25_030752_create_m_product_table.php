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
        Schema::create('m_product', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_salon')->constrained('m_salon')->onDelete('cascade');
            $table->foreignId('id_supplier')->nullable()->constrained('m_supplier')->onDelete('set null');
            $table->string('brand');
            $table->string('nama');
            $table->string('ukuran')->nullable();
            $table->string('satuan');
            $table->decimal('harga_satuan', 15, 2)->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_product');
    }
};
