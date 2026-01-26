<?php

namespace App\Filament\Resources\MentorFeedbackResource\Pages;

use App\Filament\Resources\MentorFeedbackResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListMentorFeedback extends ListRecords
{
    protected static string $resource = MentorFeedbackResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
