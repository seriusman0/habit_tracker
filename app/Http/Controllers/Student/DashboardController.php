<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\DailyReflection;
use App\Models\HabitCategory;
use Illuminate\Http\Request;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index()
    {
        $user = auth()->user();
        $studentId = $user->id;
        $today = now()->toDateString();

        // 1. Fetch Habits assigned via Pivot (Drag & Drop)
        $assignedHabits = $user->habits()
            // Check pivot active status if column exists, otherwise assume habit is active
            // The relationship 'habits' in User model includes withPivot(['is_active'])
            ->wherePivot('is_active', true)
            ->with(['category', 'logs' => function ($query) use ($today) {
                $query->whereDate('log_date', $today);
            }])
            ->get()
            ->each(function ($habit) {
                // Override attributes with pivot data if available
                if ($habit->pivot) {
                    $habit->color = $habit->pivot->color ?? $habit->color;
                    $habit->frequency = $habit->pivot->frequency ?? $habit->frequency;
                }
            });

        // 2. Fetch Habits directly owned (student_id = user_id)
        $ownedHabits = \App\Models\Habit::where('student_id', $studentId)
            ->where('is_active', true)
            ->with(['category', 'logs' => function ($query) use ($today) {
                $query->whereDate('log_date', $today);
            }])
            ->get();

        // 3. Merge and formatting
        $allHabits = $assignedHabits->merge($ownedHabits)
            ->unique('id') // Prevent duplicates if somehow linked both ways
            ->transform(function ($habit) {
                $habit->todays_log = $habit->logs->first();
                unset($habit->logs);
                return $habit;
            });

        // 4. Group by Category
        $categories = $allHabits->groupBy(function ($habit) {
            return $habit->category_id ?? 'uncategorized';
        })->map(function ($habits, $categoryId) {
            if ($categoryId === 'uncategorized') {
                return [
                    'id' => null,
                    'name' => 'General Habits',
                    'habits' => $habits->values()->toArray(),
                    'sort_order' => 999
                ];
            }

            $category = $habits->first()->category;
            return [
                'id' => $categoryId,
                'name' => $category->name,
                'habits' => $habits->sortBy('sort_order')->values()->toArray(),
                // Use a default sort order if category doesn't have one, or 0
                'sort_order' => $category->sort_order ?? 0
            ];
        })->sortBy('sort_order')->values();

        $todaysReflection = DailyReflection::where('student_id', $studentId)
            ->whereDate('ref_date', $today)
            ->first();

        return Inertia::render('Student/Dashboard', [
            'categories' => $categories,
            'todaysReflection' => $todaysReflection,
        ]);
    }
}
