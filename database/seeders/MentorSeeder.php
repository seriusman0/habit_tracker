<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class MentorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Default Mentor
        $mentor = User::factory()->create([
            'name' => 'Mentor User',
            'username' => 'mentor',
            'email' => 'mentor@gmail.com',
            'password' => Hash::make('password'),
        ]);
        $mentor->assignRole('mentor');

        // Create some random mentors
        User::factory()->count(5)->create()->each(function ($user) {
            $user->assignRole('mentor');
        });
    }
}
