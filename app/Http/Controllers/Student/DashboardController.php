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
        $studentId = auth()->id();
        $today = now()->toDateString();

        // Fetch categories with active habits for the student
        $categories = HabitCategory::where('student_id', $studentId)
            ->with(['habits' => function ($query) use ($studentId, $today) {
                $query->where('student_id', $studentId)
                    ->where('is_active', true)
                    ->orderBy('sort_order')
                    ->with(['logs' => function ($q) use ($today) {
                        $q->whereDate('log_date', $today);
                    }]);
            }])
            ->orderBy('sort_order')
            ->get()
            ->map(function ($category) {
                $category->habits->transform(function ($habit) {
                    $habit->todays_log = $habit->logs->first();
                    unset($habit->logs);
                    return $habit;
                });
                return $category;
            });

        // Also fetch habits that don't belong to any category (uncategorized)
        $uncategorizedHabits = \App\Models\Habit::where('student_id', $studentId)
            ->whereNull('category_id')
            ->where('is_active', true)
            ->orderBy('sort_order')
            ->with(['logs' => function ($q) use ($today) {
                $q->whereDate('log_date', $today);
            }])
            ->get()
            ->transform(function ($habit) {
                $habit->todays_log = $habit->logs->first();
                unset($habit->logs);
                return $habit;
            });

        if ($uncategorizedHabits->isNotEmpty()) {
            // Create a pseudo-category for display
            $defaultCategory = new HabitCategory([
                'id' => null,
                'name' => 'General Habits',
                'sort_order' => 999
            ]);
            $defaultCategory->setRelation('habits', $uncategorizedHabits);
            $categories->push($defaultCategory);
        }

        $todaysReflection = DailyReflection::where('student_id', $studentId)
            ->whereDate('ref_date', $today)
            ->first();

        return Inertia::render('Student/Dashboard', [
            'categories' => $categories,
            'todaysReflection' => $todaysReflection,
        ]);
    }
}
