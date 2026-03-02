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
        Schema::table('habit_logs', function (Blueprint $table) {
            // MySQL menggunakan Unique Index sebagai sandaran Foreign Key.
            // Maka kita harus men-drop Foreign Key-nya terlebih dahulu.
            $table->dropForeign(['habit_id']);

            // Hapus index unik lama
            $table->dropUnique('habit_logs_habit_id_date_unique');

            // Tambahkan index unik komposit 3 kolom
            $table->unique(['student_id', 'habit_id', 'log_date']);

            // Kembalikan Foreign Key
            $table->foreign('habit_id')->references('id')->on('habits')->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('habit_logs', function (Blueprint $table) {
            $table->dropForeign(['habit_id']);
            $table->dropUnique(['student_id', 'habit_id', 'log_date']);

            $table->unique(['habit_id', 'log_date'], 'habit_logs_habit_id_date_unique');
            $table->foreign('habit_id')->references('id')->on('habits')->cascadeOnDelete();
        });
    }
};
