<?php

namespace App\Http\Controllers\Mentor;

use App\Http\Controllers\Controller;
use App\Models\DailyReflection;
use App\Models\Habit;
use App\Models\HabitCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class MyHabitController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        $studentId = $user->id; // Treat Mentor as 'student_id' owner of their habits
        $today = now()->toDateString();

        // Fetch Habits directly owned by Mentor
        // Mentors don't have "assigned" habits via pivot in this context (self-managed)
        $habits = Habit::where('student_id', $studentId)
            ->where('is_active', true)
            ->with(['category', 'logs' => function ($query) use ($today) {
                $query->whereDate('log_date', $today);
            }])
            ->get()
            ->transform(function ($habit) {
                $habit->todays_log = $habit->logs->first();
                unset($habit->logs);
                return $habit;
            });

        // Group by Category
        $categories = $habits->whereNotNull('category_id')
            ->groupBy('category_id')
            ->map(function ($habits, $categoryId) {
                $category = $habits->first()->category;
                return [
                    'id' => $categoryId,
                    'name' => $category ? $category->name : 'Unknown',
                    'habits' => $habits->sortBy('id')->values()->toArray(),
                ];
            })->sortBy('id')->values();

        // Handle Uncategorized
        $uncategorized = $habits->whereNull('category_id');
        if ($uncategorized->isNotEmpty()) {
            $categories->push([
                'id' => 'uncategorized',
                'name' => 'Lainnya',
                'habits' => $uncategorized->sortBy('id')->values()->toArray(),
            ]);
        }

        // Reflection (Optional for Mentor, but keeping for UI consistency)
        $todaysReflection = DailyReflection::where('student_id', $studentId)
            ->whereDate('ref_date', $today)
            ->first();

        return Inertia::render('Mentor/MyHabits', [
            'categories' => $categories,
            'todaysReflection' => $todaysReflection,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'category_name' => 'nullable|string|max:255',
        ]);

        $userId = Auth::id();
        $categoryId = null;

        if ($request->filled('category_name')) {
            $category = HabitCategory::firstOrCreate(
                ['student_id' => $userId, 'name' => $request->category_name],
                []
            );
            $categoryId = $category->id;
        }

        Habit::create([
            'student_id' => $userId, // Mentor is the 'student' (owner)
            'category_id' => $categoryId,
            'title' => $validated['title'],
            'is_active' => true,
            'created_by_user_id' => $userId,
            'color' => 'bg-indigo-500', // Default
            'frequency' => 'daily', // Default
        ]);

        return back();
    }

    public function toggle(Request $request, Habit $habit)
    {
        $userId = Auth::id();

        // Security check: Ensure Mentor owns this habit
        if ($habit->student_id !== $userId) {
            abort(403);
        }

        $today = now()->toDateString();
        $log = $habit->logs()
            ->where('student_id', $userId)
            ->whereDate('log_date', $today)
            ->first();

        if ($log) {
            if ($request->has('status')) {
                $log->update(['status' => $request->input('status'), 'logged_at' => now()]);
            } else {
                $log->delete(); // Undo
            }
        } else {
            $habit->logs()->create([
                'student_id' => $userId,
                'log_date' => $today,
                'status' => $request->input('status', 'completed'),
                'logged_at' => now(),
            ]);
        }

        return back();
    }
}
