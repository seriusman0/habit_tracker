<?php

namespace App\Filament\Mentor\Resources;

use App\Filament\Mentor\Resources\MyClassResource\RelationManagers;
use App\Filament\Mentor\Resources\MyClassResource\Pages;
use App\Models\Classroom;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class MyClassResource extends Resource
{
    protected static ?string $model = Classroom::class;

    protected static ?string $slug = 'my-classes';

    protected static ?string $modelLabel = 'My Class';
    protected static ?string $pluralModelLabel = 'My Classes';

    protected static ?string $navigationIcon = 'heroicon-o-home';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->required()
                    ->readOnly(), // Mentors might strictly view or edit description only? Let's check req. "create room" said admin. So mentor likely just views. 
                // Let's allow editing description but not name/mentor.
                Forms\Components\Textarea::make('description')
                    ->columnSpanFull(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->url(fn($record) => Pages\EditMyClass::getUrl(['record' => $record])),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make()
                    ->label('View Class')
                    ->icon('heroicon-o-eye'),
            ])
            ->bulkActions([]);
    }

    public static function getRelations(): array
    {
        return [
            RelationManagers\StudentsRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListMyClasses::route('/'),
            'edit' => Pages\EditMyClass::route('/{record}/edit'),
        ];
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()->where('mentor_id', auth()->id());
    }
}
