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
        Schema::table('habit_categories', function (Blueprint $table) {
            $table->dropForeign(['student_id']);
            $table->dropColumn(['student_id', 'subtitle', 'color', 'sort_order']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('habit_categories', function (Blueprint $table) {
            $table->foreignId('student_id')->nullable()->constrained('users');
            $table->string('subtitle')->nullable();
            $table->string('color')->nullable();
            $table->integer('sort_order')->default(0);
        });
    }
};
