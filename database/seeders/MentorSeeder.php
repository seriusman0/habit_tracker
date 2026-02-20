<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class MentorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $mentors = [
            'Theodorus Patrick',
            'Ade Puan',
            'Kristiani',
            'Meidhora',
            'Widya',
            'Tabitha',
            'Tri',
            'Ras Enchari',
            'Krisyanto Edo',
            'Obaja',
            'Amelia',
            'Della',
            'Cecilia',
            'Donfri',
            'Mikhael',
            'Oswald',
            'Margareth',
            'Romario',
            'Naomi',
            'Herdiyanto',
            'Artha',
            'Nethania',
        ];

        DB::transaction(function () use ($mentors) {
            // 1. Prepare the valid email list for cleanup
            $validEmails = collect($mentors)->map(function ($name) {
                return $this->generateEmail($name);
            })->toArray();

            // 2. Cleanup: Remove users with 'mentor' role who are NOT in the valid list
            //    Safeguard: Ensure we don't delete admins.
            //    We get all users who HAVE the mentor role.
            $usersToDelete = User::role('mentor')
                ->whereNotIn('email', $validEmails)
                ->get();

            foreach ($usersToDelete as $user) {
                // Double check to prevent deleting admins, just in case a user has both roles
                if (! $user->hasRole('admin')) {
                    $user->delete();
                }
            }

            // 3. Seeding
            foreach ($mentors as $name) {
                $email = $this->generateEmail($name);

                // Assuming username is required and unique
                $username = Str::slug($name, '_');

                $user = User::updateOrCreate(
                    ['email' => $email],
                    [
                        'name' => $name,
                        'username' => $username,
                        'password' => Hash::make('password'), // Default password
                        'email_verified_at' => now(),
                    ]
                );

                // Assign role if not already assigned
                if (! $user->hasRole('mentor')) {
                    $user->assignRole('mentor');
                }
            }
        });
    }

    private function generateEmail(string $name): string
    {
        return Str::lower(Str::slug($name, '_')) . '@email.com';
    }
}
