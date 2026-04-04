<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ReportingResource\Pages;
use App\Models\User;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class ReportingResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $slug = 'reporting';

    protected static ?string $modelLabel = 'Student Report';
    protected static ?string $pluralModelLabel = 'Reporting';

    protected static ?string $navigationIcon = 'heroicon-o-chart-pie';
    protected static ?string $navigationGroup = 'Academic';
    protected static ?int $navigationSort = 2;

    public static function form(Form $form): Form
    {
        return $form->schema([]);
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
            ->searchable(),
        ])
            ->filters([
            //
        ])
            ->actions([
            Tables\Actions\Action::make('report')
            ->label('View Report')
            ->icon('heroicon-o-chart-bar')
            ->color('info')
            ->url(fn(User $record): string => ReportingResource::getUrl('report', ['record' => $record])),
        ])
            ->bulkActions([]);
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()->whereHas('roles', function ($query) {
            $query->where('name', 'student');
        });
    }

    public static function getRelations(): array
    {
        return [];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListReportings::route('/'),
            'report' => Pages\ViewStudentReport::route('/{record}/report'),
        ];
    }
}
