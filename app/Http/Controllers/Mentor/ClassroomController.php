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

        // If no templates exist, maybe fetch some "Generic" ones or just empty.

        return response()->json([
            'classroom' => $classroom,
            'students' => $classroom->students,
            'templates' => $templates,
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

        // Create a copy of the habit for the student
        $newHabit = Habit::create([
            'student_id' => $student->id,
            'title' => $template->title,
            'description' => $template->description,
            'category_id' => $template->category_id,
            'color' => $template->color,
            'frequency' => $template->frequency,
            'target_time' => $template->target_time,
            'is_active' => true,
            'created_by_user_id' => auth()->id(),
        ]);

        return response()->json([
            'message' => 'Habit assigned successfully',
            'habit' => $newHabit,
        ]);
    }
}
