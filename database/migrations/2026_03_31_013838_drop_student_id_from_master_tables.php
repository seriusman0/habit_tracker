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
        Schema::table('habits', function (Blueprint $table) {
            if (Schema::hasColumn('habits', 'student_id')) {
                // Drop foreign key explicitly by its likely original name 'habits_user_id_foreign' or array
                Schema::getConnection()->statement('ALTER TABLE habits DROP FOREIGN KEY habits_user_id_foreign');
                $table->dropColumn('student_id');
            }
        });

        Schema::table('habit_categories', function (Blueprint $table) {
            if (Schema::hasColumn('habit_categories', 'student_id')) {
                Schema::getConnection()->statement('ALTER TABLE habit_categories DROP FOREIGN KEY habit_categories_student_id_foreign');
                $table->dropColumn('student_id');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('habits', function (Blueprint $table) {
            if (!Schema::hasColumn('habits', 'student_id')) {
                $table->unsignedBigInteger('student_id')->nullable();
            }
        });

        Schema::table('habit_categories', function (Blueprint $table) {
            if (!Schema::hasColumn('habit_categories', 'student_id')) {
                $table->unsignedBigInteger('student_id')->nullable();
            }
        });
    }
};
