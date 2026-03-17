<?php

namespace App\Filament\Resources\ReportingResource\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StudentReportStats extends BaseWidget
{
    use \Filament\Widgets\Concerns\InteractsWithPageTable;

    public ?\Illuminate\Database\Eloquent\Model $record = null;

    protected function getStats(): array
    {
        if (!$this->record) {
            return [];
        }

        $stats = \App\Models\HabitLog::selectRaw('
            count(*) as total_logs,
            sum(case when status = "completed" then 1 else 0 end) as total_completed,
            sum(case when status = "failed" or status = "skipped" then 1 else 0 end) as total_missed
        ')
            ->where('student_id', $this->record->id)
            ->first();

        $totalLogs = $stats->total_logs ?? 0;
        $completed = $stats->total_completed ?? 0;
        $missed = $stats->total_missed ?? 0;

        $percentage = $totalLogs > 0 ? round(($completed / $totalLogs) * 100) : 0;

        return [
            Stat::make('Tingkat Kesuksesan Habit', $percentage . '%')
            ->description('Dari seluruh catatan yang ada')
            ->descriptionIcon($percentage >= 70 ? 'heroicon-m-arrow-trending-up' : 'heroicon-m-arrow-trending-down')
            ->color($percentage >= 70 ? 'success' : 'danger'),

            Stat::make('Total Melakukan', $completed)
            ->description('Jumlah habit berjalan sesuai jadwal')
            ->color('success'),

            Stat::make('Total Tidak Melakukan', $missed)
            ->description('Jumlah habit yang terlewat atau gagal')
            ->color('danger'),
        ];
    }
}
