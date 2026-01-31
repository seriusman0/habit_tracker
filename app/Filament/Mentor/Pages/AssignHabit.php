<?php

namespace App\Filament\Mentor\Pages;

use App\Models\Habit;
use App\Models\User;
use Filament\Actions\Action;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Pages\Page;

class AssignHabit extends Page implements HasForms
{
    use InteractsWithForms;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    protected static string $view = 'filament.mentor.pages.assign-habit';

    public ?array $data = [];

    public function mount(): void
    {
        $this->form->fill();
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Select::make('student_id')
                    ->label('Student')
                    ->options(function () {
                        // Get students assigned to this mentor
                        return User::where('role', 'student')
                            ->whereHas('classrooms', function ($query) {
                                $query->where('mentor_id', auth()->id());
                            })
                            ->pluck('name', 'id');
                    })
                    ->searchable()
                    ->required(),
                TextInput::make('title')
                    ->required(),
                Select::make('frequency')
                    ->options([
                        'daily' => 'Daily',
                        'weekly' => 'Weekly',
                    ])
                    ->default('daily')
                    ->required(),
                // Add more fields if needed matching Habit model
            ])
            ->statePath('data');
    }

    public function create(): void
    {
        $data = $this->form->getState();

        $studentId = $data['student_id'];

        // Create the habit "for" the student
        // We set created_by_user_id to the student so it appears as THEIR habit
        // Or should we set it to Mentor and use another field? 
        // Based on my previous fix to User::habits(), it uses created_by_user_id.
        // So I MUST set created_by_user_id to the Student ID.

        Habit::create([
            'title' => $data['title'],
            'frequency' => $data['frequency'],
            'created_by_user_id' => $studentId, // Magic: Student owns it
            'updated_by_user_id' => auth()->id(), // Mentor touched it
            'is_active' => true,
            'color' => '#4F46E5', // Default color
            // category_id? nullable.
        ]);

        Notification::make()
            ->success()
            ->title('Habit assigned successfully')
            ->send();

        $this->form->fill();
    }
}
