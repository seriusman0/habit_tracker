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
        // 1. Add student_id back to habits table, nullable for templates
        Schema::table('habits', function (Blueprint $table) {
            if (!Schema::hasColumn('habits', 'student_id')) {
                $table->foreignId('student_id')->nullable()->constrained('users')->cascadeOnDelete();
            }
        });

        // 2. Make student_id in habit_categories nullable to support template categories
        Schema::table('habit_categories', function (Blueprint $table) {
            // Modify existing column to be nullable
            $table->foreignId('student_id')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('habits', function (Blueprint $table) {
            // We can't easily revert "adding nullable" without losing data if we enforced it, 
            // but for down() we usually drop the column.
            $table->dropForeign(['student_id']);
            $table->dropColumn('student_id');
        });

        Schema::table('habit_categories', function (Blueprint $table) {
            // Revert to not nullable (requires data cleanup, might fail if nulls exist)
            // $table->foreignId('student_id')->nullable(false)->change();
        });
    }
};
