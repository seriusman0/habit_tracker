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
                // Legacy action removed in favor of Row and Bulk actions
            ])
            ->actions([
                Tables\Actions\Action::make('assignHabit')
                    ->label('Assign Habit')
                    ->icon('heroicon-o-plus-circle')
                    ->form([
                        Forms\Components\Select::make('habit_id')
                            ->label('Select Habit Template')
                            ->options(fn() => Habit::whereNull('student_id')->where('created_by_user_id', Auth::id())->pluck('title', 'id'))
                            ->searchable()
                            ->preload()
                            ->required()
                            ->live()
                            ->afterStateUpdated(function ($state, Forms\Set $set) {
                                if ($state) {
                                    $habit = Habit::find($state);
                                    if ($habit) {
                                        $set('frequency', $habit->frequency);
                                        $set('color', $habit->color);
                                    }
                                }
                            }),
                        Forms\Components\Select::make('frequency')
                            ->options([
                                'daily' => 'Daily',
                                'weekly' => 'Weekly',
                            ])
                            ->required(),
                        Forms\Components\ColorPicker::make('color')
                            ->required(),
                    ])
                    ->action(function (array $data, \App\Models\User $record) {
                        // Check if already assigned
                        if (!$record->habits()->where('habit_id', $data['habit_id'])->exists()) {
                            $record->habits()->attach($data['habit_id'], [
                                'color' => $data['color'],
                                'frequency' => $data['frequency'],
                                'is_active' => true,
                            ]);

                            \Filament\Notifications\Notification::make()
                                ->title('Habit assigned to ' . $record->name)
                                ->success()
                                ->send();
                        } else {
                            \Filament\Notifications\Notification::make()
                                ->title('Habit already assigned to ' . $record->name)
                                ->warning()
                                ->send();
                        }
                    }),
            ])
            ->bulkActions([
                Tables\Actions\BulkAction::make('assignHabitToSelected')
                    ->label('Assign Habit to Selected')
                    ->icon('heroicon-o-plus-circle')
                    ->form([
                        Forms\Components\Select::make('habit_id')
                            ->label('Select Habit Template')
                            ->options(fn() => Habit::whereNull('student_id')->where('created_by_user_id', Auth::id())->pluck('title', 'id'))
                            ->searchable()
                            ->preload()
                            ->required()
                            ->live()
                            ->afterStateUpdated(function ($state, Forms\Set $set) {
                                if ($state) {
                                    $habit = Habit::find($state);
                                    if ($habit) {
                                        $set('frequency', $habit->frequency);
                                        $set('color', $habit->color);
                                    }
                                }
                            }),
                        Forms\Components\Select::make('frequency')
                            ->options([
                                'daily' => 'Daily',
                                'weekly' => 'Weekly',
                            ])
                            ->required(),
                        Forms\Components\ColorPicker::make('color')
                            ->required(),
                    ])
                    ->action(function (Collection $records, array $data) {
                        foreach ($records as $student) {
                            if (!$student->habits()->where('habit_id', $data['habit_id'])->exists()) {
                                $student->habits()->attach($data['habit_id'], [
                                    'frequency' => $data['frequency'],
                                    'color' => $data['color'],
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
