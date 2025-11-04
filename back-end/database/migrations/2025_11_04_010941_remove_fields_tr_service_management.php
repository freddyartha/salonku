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
        Schema::table('tr_service_management', function (Blueprint $table) {
            $table->dropColumn('nama');
            $table->dropColumn('deskripsi');
            $table->dropColumn('harga');
        });
    }

    public function down(): void
    {
        Schema::table('tr_service_management', function (Blueprint $table) {
            $table->string('nama')->nullable();
            $table->text('deskripsi')->nullable();
            $table->decimal('harga', 15, 2)->default(0)->nullable();
        });
    }
};
