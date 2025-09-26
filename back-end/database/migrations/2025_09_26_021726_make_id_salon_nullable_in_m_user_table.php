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
        Schema::table('m_user', function (Blueprint $table) {
             // Drop foreign key
            $table->dropForeign(['id_salon']);

            // Ubah kolom
            $table->unsignedBigInteger('id_salon')->nullable()->change();

            // Tambahkan foreign key lagi
            $table->foreign('id_salon')->references('id')->on('m_salon')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('m_user', function (Blueprint $table) {
            $table->unsignedBigInteger('id_salon')->nullable(false)->change();
        });
    }
};
