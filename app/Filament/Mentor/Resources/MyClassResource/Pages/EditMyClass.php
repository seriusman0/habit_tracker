<?php

namespace App\Filament\Mentor\Resources\MyClassResource\Pages;

use App\Filament\Mentor\Resources\MyClassResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;
use Filament\Support\Enums\MaxWidth;

class EditMyClass extends EditRecord
{
    protected static string $resource = MyClassResource::class;

    protected function getHeaderActions(): array
    {
        return [
            // Actions\DeleteAction::make(), // Optional: Can mentor delete class? Probably not if admin manages structure.
        ];
    }

    public function getMaxContentWidth(): MaxWidth | string | null
    {
        return MaxWidth::Full;
    }

    public function getFooterWidgetsColumns(): int | array
    {
        return 1;
    }

    protected function getFooterWidgets(): array
    {
        return [
            \App\Filament\Mentor\Widgets\HabitAssignmentWidget::class,
        ];
    }
}
