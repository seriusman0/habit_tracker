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
        $this->call(RoleSeeder::class);

        // Test User (Main)
        $user = User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'username' => 'tester',
            'password' => bcrypt('password'),
        ]);

        // Friend User
        $friend = User::factory()->create([
            'name' => 'Friend User',
            'email' => 'friend@example.com',
            'username' => 'friend',
            'password' => bcrypt('password'),
        ]);

        // Create a Habit for Test User
        $habit = \App\Models\Habit::create([
            'user_id' => $user->id,
            'title' => 'Morning Jog',
            'description' => 'Run 5km every morning',
            'color' => '#10B981', // Emerald
            'frequency' => 'daily',
        ]);
    }
}
