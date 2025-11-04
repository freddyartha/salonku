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
            $table->unsignedBigInteger('id_client')->nullable()->change();
            $table->unsignedBigInteger('id_salon')->nullable(false)->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tr_service_management', function (Blueprint $table) {
            $table->unsignedBigInteger('id_client')->nullable(false)->change();
            $table->unsignedBigInteger('id_salon')->nullable()->change();
        });
    }
};
