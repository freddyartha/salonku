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
            $table->dropForeign(['id_service']);
            $table->dropColumn('id_service');
        });
    }

    public function down(): void
    {
        Schema::table('tr_service_management', function (Blueprint $table) {
            $table->foreignId('id_service')->nullable()->constrained('m_service')->onDelete('cascade');
        });
    }
};
