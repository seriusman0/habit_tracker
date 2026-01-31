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
        Schema::create('habit_user', function (Blueprint $table) {
            $table->id();
            $table->foreignId('habit_id')->constrained()->cascadeOnDelete();
            $table->foreignId('student_id')->constrained('users')->cascadeOnDelete(); // Renamed to student_id for clarity in pivot context
            $table->string('color')->nullable(); // Allow overriding template color
            $table->string('frequency')->default('daily'); // Allow overriding template frequency
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->unique(['habit_id', 'student_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('habit_user');
    }
};
