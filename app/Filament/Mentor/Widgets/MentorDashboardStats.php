<?php

namespace App\Filament\Mentor\Widgets;

use Filament\Widgets\Widget;
use App\Models\Classroom;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class MentorDashboardStats extends Widget
{
    protected static ?int $sort = -1;
    protected int | string | array $columnSpan = 'full';
    protected static string $view = 'filament.mentor.widgets.mentor-dashboard-stats';

    protected function getViewData(): array
    {
        $mentorId = Auth::id();

        // Count classes
        $classCount = Classroom::where('mentor_id', $mentorId)->count();

        // Count students in mentor's classes (distinct students)
        $studentCount = User::whereHas('classrooms', function ($query) use ($mentorId) {
            $query->where('mentor_id', $mentorId);
        })->count();

        // Count active assigned habits for these students
        // We look for habits attached to students who are in this mentor's classes
        $assignedHabitsCount = \Illuminate\Support\Facades\DB::table('habit_user')
            ->whereIn('student_id', function ($query) use ($mentorId) {
                $query->select('student_id') // Corrected column name
                    // User::classrooms() -> pivot 'classroom_students', 'student_id', 'classroom_id'
                    ->from('classroom_students')
                    ->whereIn('classroom_id', function ($q) use ($mentorId) {
                        $q->select('id')->from('classrooms')->where('mentor_id', $mentorId);
                    });
            })
            ->where('is_active', true)
            ->count();

        return [
            'classCount' => $classCount,
            'studentCount' => $studentCount,
            'assignedHabitsCount' => $assignedHabitsCount,
        ];
    }
}
