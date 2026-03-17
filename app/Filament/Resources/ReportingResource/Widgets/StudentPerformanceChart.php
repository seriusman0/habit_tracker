<?php

namespace App\Filament\Resources\ReportingResource\Widgets;

use Filament\Widgets\ChartWidget;

class StudentPerformanceChart extends ChartWidget
{
    protected static ?string $heading = 'Chart';

    public ?\Illuminate\Database\Eloquent\Model $record = null;

    protected function getData(): array
    {
        if (!$this->record) {
            return [];
        }

        // Ambil data 30 hari terakhir. Jika skala grafis akan berbeda, bisa diubah filter days ini.
        $thirtyDaysAgo = now()->subDays(30)->toDateString();

        $logs = \App\Models\HabitLog::selectRaw('
                log_date, 
                count(*) as total, 
                sum(case when status = "completed" then 1 else 0 end) as completed_count
            ')
            ->where('student_id', $this->record->id)
            ->where('log_date', '>=', $thirtyDaysAgo)
            ->groupBy('log_date')
            ->orderBy('log_date')
            ->get();

        // Siapkan kerangka array sumbu X (Tanggal) dan Y (Dataset)
        $labels = [];
        $completedScores = [];
        $totalAssignedScores = [];

        foreach ($logs as $log) {
            // Ubah format date ke yang lebih mudah dibaca, misal '24 Oct'
            $labels[] = \Carbon\Carbon::parse($log->log_date)->format('d M');
            $completedScores[] = (int)$log->completed_count;
            $totalAssignedScores[] = (int)$log->total;
        }

        return [
            'datasets' => [
                [
                    'label' => 'Habit Terlaksana (Selesai)',
                    'data' => $completedScores,
                    'borderColor' => '#10b981', // Emerald 500
                    'backgroundColor' => '#d1fae5', // Light Emerald
                    'fill' => 'start',
                    'tension' => 0.4, // Melengkungkan garis (kurva)
                ],
                [
                    'label' => 'Habit Ditugaskan (Target)',
                    'data' => $totalAssignedScores,
                    'borderColor' => '#6366f1', // Indigo 500
                    'borderDash' => [5, 5],
                    'fill' => false,
                ],
            ],
            'labels' => $labels,
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }
}
