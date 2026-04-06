<?php

namespace App\Filament\Resources\StudentResource\Pages;

use App\Filament\Resources\StudentResource;
use App\Models\User;
use Filament\Actions;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\ManageRecords;

class ManageStudents extends ManageRecords
{
    protected static string $resource = StudentResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('assignDefaultHabitsToAll')
                ->label('Assign Habit ke Semua Siswa')
                ->icon('heroicon-o-bolt')
                ->color('warning')
                ->requiresConfirmation()
                ->modalHeading('Assign Default Habit ke Semua Siswa')
                ->modalDescription('Semua habit aktif yang belum ada akan ditambahkan ke seluruh siswa terdaftar.')
                ->modalSubmitActionLabel('Ya, Assign Semua')
                ->action(function (): void {
                    $students = User::role('student')->get();
                    $students->each->assignDefaultHabits();
                    Notification::make()
                        ->title('Selesai')
                        ->body("Habit default berhasil ditambahkan ke {$students->count()} siswa.")
                        ->success()
                        ->send();
                }),

            Actions\CreateAction::make()
                ->after(function ($record) {
                    $record->assignRole('student');
                    $record->assignDefaultHabits();
                }),
        ];
    }
}
