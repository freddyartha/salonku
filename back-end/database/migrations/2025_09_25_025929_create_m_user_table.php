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
        Schema::create('m_user', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_salon')->constrained('m_salon')->onDelete('cascade');
            $table->string('id_user_firebase')->unique();
            $table->integer('level'); // 1: owner, 2: Karyawan
            $table->string('nama');
            $table->string('email');
            $table->string('phone');
            $table->integer('nik');
            $table->char('jenis_kelamin', 1); //L/P
            $table->dateTime('tanggal_lahir');
            $table->text('alamat');
            $table->string('avatar_url')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('m_user');
    }
};
