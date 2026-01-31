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

        return [
            'classCount' => $classCount,
            'studentCount' => $studentCount,
        ];
    }
}
