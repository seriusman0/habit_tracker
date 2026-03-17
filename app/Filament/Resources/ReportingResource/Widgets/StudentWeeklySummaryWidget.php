<?php

namespace App\Filament\Resources\ReportingResource\Widgets;

use Filament\Widgets\Widget;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
use App\Models\HabitLog;
use App\Models\Habit;

class StudentWeeklySummaryWidget extends Widget
{
    protected static string $view = 'filament.resources.reporting-resource.widgets.student-weekly-summary';

    protected int|string|array $columnSpan = 'full';

    public ?Model $record = null;

    protected function getViewData(): array
    {
        if (!$this->record) {
            return ['habitsData' => [], 'weekStart' => null, 'weekEnd' => null];
        }

        $studentId = $this->record->id;
        $weekStart = now()->startOfWeek(Carbon::MONDAY);
        $weekEnd = $weekStart->copy()->endOfWeek();

        // 1. Ambil seluruh log dalam satu tarikan minggu ini (Tidak ada N+1)
        $logs = HabitLog::where('student_id', $studentId)
            ->whereBetween('log_date', [$weekStart->toDateString(), $weekEnd->toDateString()])
            ->get()
            ->groupBy('habit_id');

        // 2. Ambil referensi jenis Habit yang tertugaskan pada Siswa
        // Merging pivot assignments and owned habits
        $assignedHabits = $this->record->habits()->wherePivot('is_active', true)->get();
        $ownedHabits = Habit::where('student_id', $studentId)->where('is_active', true)->get();

        $allHabits = $assignedHabits->merge($ownedHabits)->unique('id');

        $habitsData = [];

        foreach ($allHabits as $habit) {
            $frequency = $habit->pivot->frequency ?? $habit->frequency;
            $habitLogs = $logs->get($habit->id, collect()); // Koleksi logs spesifik habit ini

            // Siapkan slot 7 Hari (Senin - Minggu)
            $daysStatus = [
                'monday' => null,
                'tuesday' => null,
                'wednesday' => null,
                'thursday' => null,
                'friday' => null,
                'saturday' => null,
                'sunday' => null,
            ];

            foreach ($habitLogs as $log) {
                // Konversi tanggal ke nama hari (lowercase)
                $dayName = strtolower(Carbon::parse($log->log_date)->format('l'));
                if (array_key_exists($dayName, $daysStatus)) {
                    $daysStatus[$dayName] = $log->status;
                }
            }

            $habitsData[] = [
                'id' => $habit->id,
                'title' => $habit->title,
                'frequency' => strtolower($frequency),
                'days' => $daysStatus,
            ];
        }
        $summaries = app(\App\Services\WeeklySummaryService::class)->getWeeklySummariesForStudents([$studentId]);
        $summaryStats = $summaries[$studentId] ?? null;

        return [
            'habitsData' => $habitsData,
            'weekStart' => $weekStart,
            'weekEnd' => $weekEnd,
            'summaryStats' => $summaryStats,
        ];
    }
}
