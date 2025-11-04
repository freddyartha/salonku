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
            $table->string('catatan')->nullable()->after('id_cabang');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tr_service_management', function (Blueprint $table) {
            $table->dropColumn('catatan');
        });
    }
};
