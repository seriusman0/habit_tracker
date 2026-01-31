<?php

namespace App\Filament\Mentor\Resources\MyClassResource\Pages;

use App\Filament\Mentor\Resources\MyClassResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListMyClasses extends ListRecords
{
    protected static string $resource = MyClassResource::class;

    protected function getHeaderActions(): array
    {
        return [];
    }
}
