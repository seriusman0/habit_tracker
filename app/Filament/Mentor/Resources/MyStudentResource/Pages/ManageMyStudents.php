<?php

namespace App\Filament\Mentor\Resources\MyStudentResource\Pages;

use App\Filament\Mentor\Resources\MyStudentResource;
use Filament\Actions;
use Filament\Resources\Pages\ManageRecords;

class ManageMyStudents extends ManageRecords
{
    protected static string $resource = MyStudentResource::class;

    protected function getHeaderActions(): array
    {
        return [
            // No creation
        ];
    }
}
