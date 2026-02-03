<?php

namespace App\Filament\Mentor\Widgets;

use App\Models\Classroom;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;

class MyClassesListWidget extends BaseWidget
{
    protected static ?int $sort = 2;
    protected static ?string $heading = 'My Classes';
    protected int | string | array $columnSpan = 'full';

    public function table(Table $table): Table
    {
        return $table
            ->query(
                Classroom::where('mentor_id', auth()->id())->latest()
            )
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('students_count')
                    ->counts('students')
                    ->label('Total Students'),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->actions([
                Tables\Actions\Action::make('view')
                    ->url(fn(Classroom $record): string => route('filament.mentor.resources.my-classes.edit', $record))
                    ->icon('heroicon-m-eye'),
            ]);
    }
}
