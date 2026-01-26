<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DailyReflectionResource\Pages;
use App\Filament\Resources\DailyReflectionResource\RelationManagers;
use App\Models\DailyReflection;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class DailyReflectionResource extends Resource
{
    protected static ?string $model = DailyReflection::class;

    protected static ?string $navigationGroup = 'Administration';
    protected static ?int $navigationSort = 13;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('ref_date')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('student.name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('mood')
                    ->badge(),
                Tables\Columns\TextColumn::make('note')
                    ->limit(50),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('student')
                    ->relationship('student', 'name'),
            ])
            ->actions([
                //
            ])
            ->bulkActions([
                //
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
            'index' => Pages\ListDailyReflections::route('/'),
            'create' => Pages\CreateDailyReflection::route('/create'),
            'edit' => Pages\EditDailyReflection::route('/{record}/edit'),
        ];
    }
}
