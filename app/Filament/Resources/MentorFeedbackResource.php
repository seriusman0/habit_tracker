<?php

namespace App\Filament\Resources;

use App\Filament\Resources\MentorFeedbackResource\Pages;
use App\Filament\Resources\MentorFeedbackResource\RelationManagers;
use App\Models\MentorFeedback;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class MentorFeedbackResource extends Resource
{
    protected static ?string $model = MentorFeedback::class;

    protected static ?string $navigationGroup = 'Administration';
    protected static ?int $navigationSort = 14;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('class_id')
                    ->relationship('classroom', 'name')
                    ->required()
                    ->live(),
                Forms\Components\Select::make('mentor_id')
                    ->relationship('mentor', 'name', fn($query) => $query->role('mentor'))
                    ->required(),
                Forms\Components\Select::make('student_id')
                    ->relationship('student', 'name', fn($query) => $query->role('student'))
                    ->required(),
                Forms\Components\DatePicker::make('feedback_date')
                    ->required()
                    ->default(now()),
                Forms\Components\Textarea::make('message')
                    ->columnSpanFull()
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('feedback_date')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('classroom.name')
                    ->label('Class')
                    ->searchable(),
                Tables\Columns\TextColumn::make('mentor.name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('student.name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('message')
                    ->limit(30),
            ])
            ->filters([
                //
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
            'index' => Pages\ListMentorFeedback::route('/'),
            'create' => Pages\CreateMentorFeedback::route('/create'),
            'edit' => Pages\EditMentorFeedback::route('/{record}/edit'),
        ];
    }
}
