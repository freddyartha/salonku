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
        Schema::table('m_promo', function (Blueprint $table) {
            $table->dateTime('berlaku_mulai')->nullable(false)->after('potongan_persen');
            $table->dateTime('berlaku_sampai')->nullable()->after('berlaku_mulai');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('m_promo', function (Blueprint $table) {
            $table->dropColumn('berlaku_mulai');
            $table->dropColumn('berlaku_sampai');
        });
    }
};
