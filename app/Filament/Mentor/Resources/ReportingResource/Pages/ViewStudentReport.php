<?php

namespace App\Filament\Mentor\Resources\ReportingResource\Pages;

use App\Filament\Mentor\Resources\ReportingResource;
use App\Filament\Resources\ReportingResource\Widgets\StudentPerformanceChart;
use App\Filament\Resources\ReportingResource\Widgets\StudentReportStats;
use Filament\Resources\Pages\Page;

class ViewStudentReport extends Page
{
    use \Filament\Resources\Pages\Concerns\InteractsWithRecord;

    protected static string $resource = ReportingResource::class;

    // Reuse View Blade dari folder milik Admin
    protected static string $view = 'filament.resources.reporting-resource.pages.view-student-report';

    public function mount(int|string $record): void
    {
        // Parameter record otomatis dienkapsulasi dari URL model Binding
        $this->record = $this->resolveRecord($record);
    }

    protected function getHeaderWidgets(): array
    {
        // Reuse logika widget milik Admin (Menjauhi N+1 Logika Duplikasi)
        return [
            \App\Filament\Resources\ReportingResource\Widgets\StudentWeeklySummaryWidget::make(['record' => $this->record]),
            StudentReportStats::make(['record' => $this->record]),
            StudentPerformanceChart::make(['record' => $this->record]),
        ];
    }
}
