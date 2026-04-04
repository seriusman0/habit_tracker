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

        // 2. (Removed directly owned habits fetch as all habits use pivot now)

        // 3. Formatting
        $allHabits = $assignedHabits
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

        $uncategorized = $allHabits->whereNull('category_id');
        if ($uncategorized->isNotEmpty()) {
            $categories->push([
                'id' => 'uncategorized',
                'name' => 'Lainnya',
                'habits' => $uncategorized->sortBy('id')->values()->toArray(),
            ]);
        }

        $todaysReflection = DailyReflection::where('student_id', $studentId)
            ->whereDate('ref_date', $today)
            ->first();

        // 5. Fetch Classrooms and today's attendance for the student
        /** @var \App\Models\User $user */
        $classrooms = $user->classrooms()->with(['attendances' => function ($q) use ($today, $studentId) {
            $q->where('student_id', $studentId)
              ->whereDate('date', $today);
        }])->get()->map(function ($classroom) {
            $classroom->todays_attendance = $classroom->attendances->first();
            unset($classroom->attendances);
            return $classroom;
        });

        return Inertia::render('Student/Dashboard', [
            'categories' => $categories,
            'todaysReflection' => $todaysReflection,
            'classrooms' => $classrooms,
        ]);
    }
}
