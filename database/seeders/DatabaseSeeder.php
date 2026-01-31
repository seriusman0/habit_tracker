<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            RoleSeeder::class,
            HabitCategorySeeder::class,
            MentorSeeder::class,
        ]);

        // Student User
        $student = User::factory()->create([
            'name' => 'Student User',
            'email' => 'student@gmail.com',
            'username' => 'student',
            'password' => bcrypt('password'),
        ]);
        $student->assignRole('student');

        // Initial Habit for Student
        \App\Models\Habit::create([
            'created_by_user_id' => $student->id,
            'student_id' => $student->id,
            'title' => 'Complete Homework',
            'description' => 'Finish math assignment',
            'color' => '#3B82F6', // Blue
            'frequency' => 'daily',
            'is_active' => true,
        ]);
    }
}
