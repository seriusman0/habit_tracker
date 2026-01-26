<?php

namespace App\Filament\Resources\HabitCategoryResource\Pages;

use App\Filament\Resources\HabitCategoryResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditHabitCategory extends EditRecord
{
    protected static string $resource = HabitCategoryResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
