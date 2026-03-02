<?php

namespace App\Services;

use App\Models\Habit;
use App\Models\HabitLog;
use Carbon\Carbon;
use Illuminate\Support\Collection;

class WeeklySummaryService
{
    /**
     * Get weekly aggregation summary for a list of student IDs.
     * 
     * @param Collection|array $studentIds
     * @return array
     */
    public function getWeeklySummariesForStudents($studentIds): array
    {
        $ids = is_array($studentIds) ? $studentIds : $studentIds->toArray();
        if (empty($ids))
            return [];

        $weekStart = now()->startOfWeek(Carbon::MONDAY)->toDateString();
        $weekEnd = now()->endOfWeek(Carbon::SUNDAY)->toDateString();

        // 1. Ambil Assigned & Owned Habits dalam 1 query kencang
        $habits = Habit::with(['students' => function ($q) use ($ids) {
            // Eager load only for the requested student IDs to get pivot data
            $q->whereIn('habit_user.student_id', $ids)
                ->where('habit_user.is_active', true);
        }])
            ->where(function ($query) use ($ids) {
            // Owned habits
            $query->whereIn('student_id', $ids)->where('is_active', true);
        })
            ->orWhereHas('students', function ($query) use ($ids) {
            // Assigned habits
            $query->whereIn('habit_user.student_id', $ids)->where('habit_user.is_active', true);
        })
            ->get();

        // Hitung ekspektasi (Expected) habit untuk masing-masing siswa
        $expected = collect($ids)->mapWithKeys(fn($id) => [$id => ['daily' => 0, 'weekly' => 0]]);

        foreach ($habits as $habit) {
            // Cek apakah owned by student
            $ownedBy = $ids;
            foreach ($ids as $sId) {
                $isOwned = $habit->student_id === $sId;
                $assignedPivot = $habit->students->firstWhere('id', $sId);

                if ($isOwned || $assignedPivot) {
                    $frequency = $assignedPivot ? ($assignedPivot->pivot->frequency ?? $habit->frequency) : $habit->frequency;

                    if ($frequency === 'daily') {
                        $expected[$sId]['daily'] += 7; // Ekpektasi 7 kali seminggu
                    }
                    elseif ($frequency === 'weekly') {
                        $expected[$sId]['weekly'] += 1; // 1 kali seminggu
                    }
                }
            }
        }

        // 2. Ambil seluruh logs "completed" minggu ini
        $logs = HabitLog::whereIn('student_id', $ids)
            ->whereBetween('log_date', [$weekStart, $weekEnd])
            ->where('status', 'completed')
            ->get()
            ->groupBy('student_id');

        // 3. Gabungkan hasil hitungan (Map)
        $summaries = [];
        foreach ($ids as $sId) {
            $studentLogs = $logs->get($sId, collect());

            $dailyCompleted = 0;
            $weeklyCompleted = 0;

            foreach ($studentLogs as $log) {
                // Cari habit untuk menentukan letak counter log ini bersandar
                $habitRef = $habits->firstWhere('id', $log->habit_id);
                if ($habitRef) {
                    $assignedPivot = $habitRef->students->firstWhere('id', $sId);
                    $freq = $assignedPivot ? ($assignedPivot->pivot->frequency ?? $habitRef->frequency) : $habitRef->frequency;

                    if ($freq === 'weekly') {
                        $weeklyCompleted++;
                    }
                    else {
                        $dailyCompleted++;
                    }
                }
            }

            // Cap weekly completion at expected (misal double submit walau dicegah controller)
            $weeklyCompleted = min($weeklyCompleted, $expected[$sId]['weekly']);
            // Cap daily completion
            $dailyCompleted = min($dailyCompleted, $expected[$sId]['daily']);

            $totalExpected = $expected[$sId]['daily'] + $expected[$sId]['weekly'];
            $totalCompleted = $dailyCompleted + $weeklyCompleted;
            $percentage = $totalExpected > 0 ? round(($totalCompleted / $totalExpected) * 100) : 0;

            $summaries[$sId] = [
                'daily_completed' => $dailyCompleted,
                'daily_expected' => $expected[$sId]['daily'],
                'weekly_completed' => $weeklyCompleted,
                'weekly_expected' => $expected[$sId]['weekly'],
                'progress_percentage' => $percentage,
            ];
        }

        return $summaries;
    }
}
