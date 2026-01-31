<?php

use App\Models\Habit;
use App\Models\HabitCategory;
use Illuminate\Support\Facades\Schema;

// Check if student_id is nullable in DB
// Actually, let's just try to create one.

try {
    // Create a category if not exists
    $category = HabitCategory::firstOrCreate([
        'name' => 'General Habits',
        'student_id' => \App\Models\User::first()?->id ?? 1 // Just for the category ownership if needed
    ]);

    $habit = new Habit();
    $habit->title = 'Test Template Habit';
    $habit->category_id = $category->id;
    $habit->color = '#ff0000';
    $habit->frequency = 'daily';
    $habit->is_active = true;
    $habit->student_id = null; // TRY NULL
    $habit->save();

    echo "Success: Created Habit with NULL student_id (ID: {$habit->id})\n";
} catch (\Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
