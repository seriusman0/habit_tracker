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

        // Create a Habit for Friend User
        $friendHabit = \App\Models\Habit::create([
            'user_id' => $friend->id,
            'title' => 'Read a Book',
            'description' => '30 mins reading',
            'color' => '#6366F1', // Indigo
            'frequency' => 'daily',
        ]);

        // Connect them as friends
        \App\Models\Friendship::create([
            'sender_id' => $user->id,
            'recipient_id' => $friend->id,
            'status' => 'accepted',
        ]);

        // Share Friend's habit with Test User
        \App\Models\HabitPermission::create([
            'habit_id' => $friendHabit->id,
            'viewer_id' => $user->id,
        ]);
    }
}
