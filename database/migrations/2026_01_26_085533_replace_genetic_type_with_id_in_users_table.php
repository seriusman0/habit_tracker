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
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('genetic_type');
            $table->foreignId('genetic_type_id')->nullable()->constrained('genetic_types')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['genetic_type_id']);
            $table->dropColumn('genetic_type_id');
            $table->string('genetic_type')->nullable(); // Re-add the string column
        });
    }
};
