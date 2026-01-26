<?php

namespace App\Filament\Resources;

use App\Filament\Resources\HabitLogResource\Pages;
use App\Filament\Resources\HabitLogResource\RelationManagers;
use App\Models\HabitLog;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class HabitLogResource extends Resource
{
    protected static ?string $model = HabitLog::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('habit_id')
                    ->required()
                    ->numeric(),
                Forms\Components\DatePicker::make('log_date')
                    ->required(),
                Forms\Components\TextInput::make('status')
                    ->required(),
                Forms\Components\TextInput::make('student_id')
                    ->numeric(),
                Forms\Components\DateTimePicker::make('logged_at'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('log_date')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('student.name')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('habit.title')
                    ->searchable(),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'completed' => 'success',
                        'skipped' => 'warning',
                        'failed' => 'danger',
                        default => 'gray',
                    }),
                Tables\Columns\TextColumn::make('logged_at')
                    ->dateTime(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('student')
                    ->relationship('student', 'name'),
            ])
            ->actions([
                // Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                // Tables\Actions\BulkActionGroup::make([
                //     Tables\Actions\DeleteBulkAction::make(),
                // ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListHabitLogs::route('/'),
            'create' => Pages\CreateHabitLog::route('/create'),
            'edit' => Pages\EditHabitLog::route('/{record}/edit'),
        ];
    }
}
