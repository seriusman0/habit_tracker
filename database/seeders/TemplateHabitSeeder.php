<?php

namespace Database\Seeders;

use App\Models\Habit;
use App\Models\HabitCategory;
use Illuminate\Database\Seeder;

class TemplateHabitSeeder extends Seeder
{
    public function run(): void
    {
        $categories = HabitCategory::all();

        foreach ($categories as $category) {
            Habit::create([
                'category_id' => $category->id,
                'title' => $category->name . ' Routine',
                'description' => 'Default routine for ' . $category->name,
                'is_active' => true,
                'student_id' => null, // Template
                'color' => '#10B981',
                'frequency' => 'daily',
            ]);
        }
    }
}
