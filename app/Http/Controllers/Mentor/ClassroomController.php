<?php

namespace App\Http\Controllers\Mentor;

use App\Http\Controllers\Controller;
use App\Models\Classroom;
use App\Models\Habit;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;

class ClassroomController extends Controller
{
    public function show(Classroom $classroom)
    {
        // Policy check expected via middleware or explicit check
        Gate::authorize('view', $classroom);

        $classroom->load(['students' => function ($q) {
            $q->select('users.id', 'users.name', 'users.email', 'users->genetic_type_id')
                ->with('habits'); // Load existing habits for students
        }]);

        // Get "Template" habits (habits with no student_id, potentially created by this mentor or admin)
        // For MVP, we might treat ALL active habits created by this mentor as templates if they have no student attached.
        // Or if we don't have distinct templates, we can fetch unique habits created by this user.
        // Let's assume habits with student_id = NULL are templates.
        $templates = Habit::whereNull('student_id')
            ->where('is_active', true)
            ->get();

        // Get today's attendances for this classroom
        /** @var \App\Models\Classroom $classroom */
        $attendances = \App\Models\Attendance::with('student:id,name')
            ->where('classroom_id', $classroom->id)
            ->whereDate('date', now()->toDateString())
            ->get();

        // If no templates exist, maybe fetch some "Generic" ones or just empty.

        return response()->json([
            'classroom' => $classroom,
            'students' => $classroom->students,
            'templates' => $templates,
            'attendances' => $attendances,
        ]);
    }

    public function assignHabit(Request $request, Classroom $classroom)
    {
        Gate::authorize('update', $classroom);

        $validated = $request->validate([
            'student_id' => 'required|exists:users,id',
            'habit_id' => 'required|exists:habits,id', // The template habit ID
        ]);

        $student = $classroom->students()->findOrFail($validated['student_id']);
        $template = Habit::findOrFail($validated['habit_id']);

        // Attach the template habit to the student via pivot instead of copying
        $student->habits()->syncWithoutDetaching([
            $template->id => [
                'color' => $template->color,
                'frequency' => $template->frequency ?? 'daily',
                'is_active' => true,
            ]
        ]);

        return response()->json([
            'message' => 'Habit assigned successfully',
            'habit' => $template, // Return template as reference
        ]);
    }
}
