<?php

namespace App\Filament\Mentor\Resources;

use App\Filament\Mentor\Resources\MyStudentResource\Pages;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class MyStudentResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $slug = 'my-student';

    protected static ?string $modelLabel = 'My Student';
    protected static ?string $pluralModelLabel = 'My Students';

    protected static ?string $navigationIcon = 'heroicon-o-user-group';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->readOnly(),
                Forms\Components\TextInput::make('email')
                    ->readOnly(),
                // Show logs or other details?
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('email')
                    ->searchable(),
                Tables\Columns\TextColumn::make('geneticType.name')
                    ->label('Genetic Type')
                    ->sortable(),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
            ])
            ->bulkActions([]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ManageMyStudents::route('/'),
        ];
    }

    public static function getEloquentQuery(): Builder
    {
        // Get students belonging to classes where auth user is mentor
        return parent::getEloquentQuery()
            ->where('role', 'student')
            ->whereHas('classrooms', function ($query) {
                $query->where('mentor_id', auth()->id());
            });
    }
}
