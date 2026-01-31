<?php

namespace App\Filament\Mentor\Resources\MyClassResource\RelationManagers;

use App\Models\Habit;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;

class StudentsRelationManager extends RelationManager
{
    protected static string $relationship = 'students';

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->required()
                    ->maxLength(255),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('name')
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('email')
                    ->searchable(),
                Tables\Columns\TextColumn::make('geneticType.name')
                    ->label('Genetic Type')
                    ->badge(),
            ])
            ->filters([
                //
            ])
            ->headerActions([
                Tables\Actions\Action::make('assignHabits')
                    ->label('Assign Habits')
                    ->icon('heroicon-o-squares-plus')
                    ->modalContent(fn($livewire) => view('filament.mentor.pages.habit-assignment-modal', [
                        'record' => $livewire->getOwnerRecord(),
                    ]))
                    ->modalSubmitAction(false)
                    ->modalCancelAction(fn($action) => $action->label('Done')->cancel())
                    ->modalWidth('7xl'),
            ])
            ->actions([
                Tables\Actions\Action::make('assignHabit')
                    ->label('Assign Habit')
                    ->icon('heroicon-o-plus-circle')
                    ->form([
                        Forms\Components\TextInput::make('title')
                            ->label('Habit Title')
                            ->required(),
                        Forms\Components\Select::make('category_id')
                            ->options(\App\Models\HabitCategory::pluck('name', 'id'))
                            ->label('Category')
                            ->searchable()
                            ->nullable(),
                        Forms\Components\ColorPicker::make('color')
                            ->default('#3b82f6')
                            ->required(),
                        Forms\Components\Select::make('frequency')
                            ->options([
                                'daily' => 'Daily',
                                'weekly' => 'Weekly',
                            ])
                            ->default('daily')
                            ->required(),
                    ])
                    ->action(function (array $data, \App\Models\User $record) {
                        // Find or create a template habit (student_id is null)
                        $habit = Habit::firstOrCreate([
                            'title' => $data['title'],
                            'category_id' => $data['category_id'],
                            'student_id' => null, // Ensure it's a template
                        ], [
                            'color' => $data['color'], // Default template color
                            'frequency' => $data['frequency'], // Default template frequency
                            'is_active' => true,
                            'created_by_user_id' => Auth::id(),
                        ]);

                        // Check if already assigned
                        if (!$record->habits()->where('habit_id', $habit->id)->exists()) {
                            $record->habits()->attach($habit->id, [
                                'color' => $data['color'],
                                'frequency' => $data['frequency'],
                                'is_active' => true,
                            ]);
                        }

                        \Filament\Notifications\Notification::make()
                            ->title('Habit assigned to ' . $record->name)
                            ->success()
                            ->send();
                    }),
            ])
            ->bulkActions([
                Tables\Actions\BulkAction::make('assignHabitToSelected')
                    ->label('Assign Habit to Selected')
                    ->icon('heroicon-o-plus-circle')
                    ->form([
                        Forms\Components\TextInput::make('title')
                            ->label('Habit Title')
                            ->required(),
                        Forms\Components\Select::make('frequency')
                            ->options([
                                'daily' => 'Daily',
                                'weekly' => 'Weekly',
                            ])
                            ->default('daily')
                            ->required(),
                        Forms\Components\Select::make('category_id')
                            ->options(\App\Models\HabitCategory::pluck('name', 'id'))
                            ->label('Category')
                            ->searchable()
                            ->nullable(),
                    ])
                    ->action(function (Collection $records, array $data) {
                        // Find or create template
                        $habit = Habit::firstOrCreate([
                            'title' => $data['title'],
                            'category_id' => $data['category_id'],
                            'student_id' => null,
                        ], [
                            'frequency' => $data['frequency'], // Default template frequency
                            // Color not in bulk form? Check Step 19: Form only has title, frequency, category.
                            'color' => '#3b82f6', // Default blue if not provided
                            'is_active' => true,
                            'created_by_user_id' => Auth::id(),
                        ]);

                        foreach ($records as $student) {
                            if (!$student->habits()->where('habit_id', $habit->id)->exists()) {
                                $student->habits()->attach($habit->id, [
                                    'frequency' => $data['frequency'],
                                    'color' => $habit->color, // Use template color
                                    'is_active' => true,
                                ]);
                            }
                        }

                        \Filament\Notifications\Notification::make()
                            ->title('Habit assigned to ' . $records->count() . ' students')
                            ->success()
                            ->send();
                    })
                    ->deselectRecordsAfterCompletion(),
            ]);
    }
}
