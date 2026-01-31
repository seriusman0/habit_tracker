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
        // Migrate existing personal habits to pivot table so they are accessible via the new Many-to-Many relationship
        \Illuminate\Support\Facades\DB::statement("
            INSERT INTO habit_user (habit_id, student_id, color, frequency, is_active, created_at, updated_at)
            SELECT id, student_id, color, frequency, is_active, created_at, updated_at
            FROM habits
            WHERE student_id IS NOT NULL
        ");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('habit_user', function (Blueprint $table) {
            //
        });
    }
};
