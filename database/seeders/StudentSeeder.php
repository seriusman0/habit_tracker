<?php

namespace Database\Seeders;

use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class StudentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $students = [
            ['name' => 'Ad. Zahira',                    'dob' => '2013-05-25', 'class' => '5 SD',  'wa' => '895342770603'],
            ['name' => 'Michayla Queen Azzhra',         'dob' => null,         'class' => '5 SD',  'wa' => '822132881113'],
            ['name' => 'Neshellya Ery Friestya',        'dob' => '2014-01-23', 'class' => '5 SD',  'wa' => '85179873642'],
            ['name' => 'Desty keyza angraini',          'dob' => '2012-12-23', 'class' => '6 SD',  'wa' => null],
            ['name' => 'Dewi Kayla Putri Ardiansyah',   'dob' => null,         'class' => '5 SD',  'wa' => '85171173015'],
            ['name' => 'Rafa Eri Mahendra',             'dob' => '2017-04-24', 'class' => '1 SD',  'wa' => null],
            ['name' => 'Arsinta Widya Ningtyas',        'dob' => '2014-05-14', 'class' => '5 SD',  'wa' => '81585242340'],
            ['name' => 'Shelvy Arifiani',               'dob' => '2013-10-27', 'class' => '5 SD',  'wa' => null],
            ['name' => 'Muhamad alif ilham',            'dob' => '2019-01-21', 'class' => 'TKB',   'wa' => null],
            ['name' => 'Kayla',                         'dob' => null,         'class' => 'TKB',   'wa' => null],
            ['name' => 'Michelle',                      'dob' => null,         'class' => '6 SD',  'wa' => null],
            ['name' => 'Marcel',                        'dob' => '2012-08-23', 'class' => '6 SD',  'wa' => null],
            ['name' => 'Helen',                         'dob' => '2016-04-20', 'class' => '3 SD',  'wa' => null],
            ['name' => 'Meira',                         'dob' => '2018-10-29', 'class' => '1 SD',  'wa' => null],
            ['name' => 'Benson',                        'dob' => '2014-04-18', 'class' => '5 SD',  'wa' => null],
            ['name' => 'Easter',                        'dob' => '2012-04-06', 'class' => '6 SD',  'wa' => null],
            ['name' => 'Nurlia',                        'dob' => '2014-06-08', 'class' => '4 SD',  'wa' => null],
            ['name' => 'Dendi',                         'dob' => null,         'class' => '2 SMP', 'wa' => null],
            ['name' => 'Daniel',                        'dob' => null,         'class' => '3 SD',  'wa' => null],
            ['name' => 'Ezekiel',                       'dob' => null,         'class' => '2 SMA', 'wa' => null],
            ['name' => 'Moscha Apricilliya Suhatmoko',  'dob' => null,         'class' => '1 SMP', 'wa' => '81233579446'],
            ['name' => 'Sofhia Celiya Suhatmoko',       'dob' => null,         'class' => '4 SD',  'wa' => '81233579446'],
            ['name' => 'Daniel Aliando Suhatmoko',      'dob' => null,         'class' => '3 SD',  'wa' => '81233579446'],
            ['name' => 'Tio',                           'dob' => null,         'class' => '3 SMA', 'wa' => null],
        ];

        DB::transaction(function () use ($students) {
            // 1. Build the valid email list from the official student roster
            $validEmails = collect($students)
                ->map(fn($s) => $this->generateEmail($s['name']))
                ->toArray();

            // 2. Cleanup: Remove users with 'student' role who are NOT in the valid list
            //    Safeguard: Never delete admins or mentors.
            $usersToDelete = User::role('student')
                ->whereNotIn('email', $validEmails)
                ->get();

            foreach ($usersToDelete as $user) {
                if (! $user->hasRole('admin') && ! $user->hasRole('mentor')) {
                    $user->delete(); // Cascades to student_profiles via FK
                }
            }

            // 3. Seed each student with updateOrCreate (idempotent)
            foreach ($students as $data) {
                $email    = $this->generateEmail($data['name']);
                $username = Str::slug($data['name'], '_');

                // Ensure username uniqueness: append counter if slug already taken by another user
                $originalUsername = $username;
                $counter = 1;
                while (User::where('username', $username)->where('email', '!=', $email)->exists()) {
                    $username = $originalUsername . '_' . $counter++;
                }

                // Create/update the user account
                $user = User::updateOrCreate(
                    ['email' => $email],
                    [
                        'name'               => $data['name'],
                        'username'           => $username,
                        'password'           => Hash::make('password'),
                        'email_verified_at'  => now(),
                    ]
                );

                // Assign 'student' role if not already assigned
                if (! $user->hasRole('student')) {
                    $user->assignRole('student');
                }

                // Parse the 'class' field into grade_level (int) and school_level (string)
                [$gradeLevel, $schoolLevel] = $this->parseClass($data['class']);

                // Create/update the student profile
                StudentProfile::updateOrCreate(
                    ['user_id' => $user->id],
                    [
                        'birth_date'     => $data['dob'],
                        'school_level'   => $schoolLevel,
                        'grade_level'    => $gradeLevel,
                        'guardian_phone' => $data['wa'] ? '0' . $data['wa'] : null,
                    ]
                );
            }
        });
    }

    /**
     * Generate a deterministic email from a student's name.
     */
    private function generateEmail(string $name): string
    {
        return Str::lower(Str::slug($name, '_')) . '@siswa.com';
    }

    /**
     * Parse a class string like "5 SD", "2 SMP", "3 SMA", or "TKB"
     * into [grade_level (int|null), school_level (string|null)].
     */
    private function parseClass(string $class): array
    {
        $class = trim($class);

        // Handle special cases first
        if (in_array(strtoupper($class), ['TKB', 'TKA', 'TK'])) {
            return [null, strtoupper($class)];
        }

        // Match pattern: "{number} {LEVEL}" e.g. "5 SD", "2 SMP", "3 SMA"
        if (preg_match('/^(\d+)\s+(SD|SMP|SMA|SMK)$/i', $class, $matches)) {
            return [(int) $matches[1], strtoupper($matches[2])];
        }

        // Fallback: store raw value in school_level
        return [null, $class];
    }
}
