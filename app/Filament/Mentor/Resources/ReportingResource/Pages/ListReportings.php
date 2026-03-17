<?php

namespace App\Filament\Mentor\Resources\ReportingResource\Pages;

use App\Filament\Mentor\Resources\ReportingResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListReportings extends ListRecords
{
    protected static string $resource = ReportingResource::class;

    protected function getHeaderActions(): array
    {
        return []; // Tabel hanya menampilkan data, tidak ada opsi Create.
    }
}
