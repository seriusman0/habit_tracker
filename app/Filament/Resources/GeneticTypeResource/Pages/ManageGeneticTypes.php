<?php

namespace App\Filament\Resources\GeneticTypeResource\Pages;

use App\Filament\Resources\GeneticTypeResource;
use Filament\Actions;
use Filament\Resources\Pages\ManageRecords;

class ManageGeneticTypes extends ManageRecords
{
    protected static string $resource = GeneticTypeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
