<?php

namespace App\Filament\Resources\DailyReflectionResource\Pages;

use App\Filament\Resources\DailyReflectionResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditDailyReflection extends EditRecord
{
    protected static string $resource = DailyReflectionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
