<?php

namespace App\Filament\Resources\ReportingResource\Pages;

use App\Filament\Resources\ReportingResource;
use Filament\Resources\Pages\Page;

class ViewStudentReport extends Page
{
    use \Filament\Resources\Pages\Concerns\InteractsWithRecord;

    protected static string $resource = ReportingResource::class;

    protected static string $view = 'filament.resources.reporting-resource.pages.view-student-report';

    public function mount(int|string $record): void
    {
        $this->record = $this->resolveRecord($record);
    }

    protected function getHeaderWidgets(): array
    {
        return [
            ReportingResource\Widgets\StudentWeeklySummaryWidget::make(['record' => $this->record]),
            ReportingResource\Widgets\StudentReportStats::make(['record' => $this->record]),
            ReportingResource\Widgets\StudentPerformanceChart::make(['record' => $this->record]),
        ];
    }
}
