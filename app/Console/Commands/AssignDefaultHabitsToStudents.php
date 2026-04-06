<?php

namespace App\Console\Commands;

use App\Models\User;
use Illuminate\Console\Command;

class AssignDefaultHabitsToStudents extends Command
{
    protected $signature = 'students:assign-default-habits';

    protected $description = 'Assign all active habits to every student who does not already have them';

    public function handle(): void
    {
        $students = User::role('student')->get();

        if ($students->isEmpty()) {
            $this->info('No students found.');
            return;
        }

        $bar = $this->output->createProgressBar($students->count());
        $bar->start();

        foreach ($students as $student) {
            $student->assignDefaultHabits();
            $bar->advance();
        }

        $bar->finish();
        $this->newLine();
        $this->info("Done. Processed {$students->count()} student(s).");
    }
}
