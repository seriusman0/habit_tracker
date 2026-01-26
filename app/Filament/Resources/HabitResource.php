<?php

namespace App\Filament\Resources;

use App\Filament\Resources\HabitResource\Pages;
use App\Filament\Resources\HabitResource\RelationManagers;
use App\Models\Habit;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class HabitResource extends Resource
{
    protected static ?string $model = Habit::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('student_id')
                    ->relationship('student', 'name', fn($query) => $query->role('student'))
                    ->required()
                    ->searchable()
                    ->preload()
                    ->live(),
                Forms\Components\Select::make('category_id')
                    ->relationship('category', 'name')
                    ->required()
                    ->searchable()
                    ->preload(),
                Forms\Components\TextInput::make('title')
                    ->required(),
                Forms\Components\Textarea::make('description')
                    ->columnSpanFull(),
                Forms\Components\TimePicker::make('target_time'),
                Forms\Components\ColorPicker::make('color')
                    ->required(),
                Forms\Components\Select::make('frequency')
                    ->options([
                        'daily' => 'Daily',
                        'weekly' => 'Weekly',
                    ])
                    ->required()
                    ->default('daily'),
                Forms\Components\Toggle::make('is_active')
                    ->required()
                    ->default(true),
                Forms\Components\TextInput::make('sort_order')
                    ->numeric()
                    ->default(0),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('title')
                    ->searchable(),
                Tables\Columns\TextColumn::make('category.name')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('student.name')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('frequency'),
                Tables\Columns\IconColumn::make('is_active')
                    ->boolean(),
                Tables\Columns\TextColumn::make('target_time'),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('student')
                    ->relationship('student', 'name'),
                Tables\Filters\SelectFilter::make('category')
                    ->relationship('category', 'name'),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
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
            'index' => Pages\ListHabits::route('/'),
            'create' => Pages\CreateHabit::route('/create'),
            'edit' => Pages\EditHabit::route('/{record}/edit'),
        ];
    }
}
