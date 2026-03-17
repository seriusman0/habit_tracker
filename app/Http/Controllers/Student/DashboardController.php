<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\DailyReflection;
use App\Models\HabitCategory;
use Illuminate\Http\Request;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        $studentId = $user->id;
        $today = now()->toDateString();
        $thisMonday = now()->startOfWeek(\Carbon\Carbon::MONDAY)->toDateString();

        // 1. Fetch Habits assigned via Pivot (Drag & Drop)
        $assignedHabits = $user->habits()
            // Check pivot active status if column exists, otherwise assume habit is active
            // The relationship 'habits' in User model includes withPivot(['is_active'])
            ->wherePivot('is_active', true)
            ->with(['category', 'logs' => function ($query) use ($today, $thisMonday, $studentId) {
            $query->where('student_id', $studentId)
                ->whereIn('log_date', [$today, $thisMonday]);
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
            ->with(['category', 'logs' => function ($query) use ($today, $thisMonday, $studentId) {
            $query->where('student_id', $studentId)
                ->whereIn('log_date', [$today, $thisMonday]);
        }])
            ->get();

        // 3. Merge and formatting
        $allHabits = $assignedHabits->merge($ownedHabits)
            ->unique('id') // Prevent duplicates if somehow linked both ways
            ->transform(function ($habit) use ($today, $thisMonday) {
            // Penentuan tanggal sentinel berdasarkan tipe rutinitas
            $targetDate = ($habit->frequency === 'weekly') ? $thisMonday : $today;

            // Cari log yang record-nya persis berada di sentinel date (Period-Based)
            // Menggunakan string date casting standar untuk mencocokan collection hasil eloquent.
            $habit->todays_log = $habit->logs->first(function ($log) use ($targetDate) {
                    return substr($log->log_date, 0, 10) === $targetDate;
                }
                );

                unset($habit->logs);
                return $habit;
            });

        // 4. Group by Category
        $categories = $allHabits->whereNotNull('category_id')
            ->groupBy('category_id')
            ->map(function ($habits, $categoryId) {
            $category = $habits->first()->category;
            return [
            'id' => $categoryId,
            'name' => $category ? $category->name : 'Unknown',
            'habits' => $habits->sortBy('id')->values()->toArray(),
            ];
        })->sortBy('id')->values();

        $todaysReflection = DailyReflection::where('student_id', $studentId)
            ->whereDate('ref_date', $today)
            ->first();

        return Inertia::render('Student/Dashboard', [
            'categories' => $categories,
            'todaysReflection' => $todaysReflection,
        ]);
    }
}
