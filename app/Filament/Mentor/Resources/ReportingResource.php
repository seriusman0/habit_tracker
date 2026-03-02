<?php

namespace App\Filament\Mentor\Resources;

use App\Filament\Mentor\Resources\ReportingResource\Pages;
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
        return parent::getEloquentQuery()
            ->role('student')
            ->whereHas('classrooms', function ($query) {
            // Policy: Hanya render jika siswa tergabung di dalam kelas-kelas binaan mentor log-in ini.
            $query->where('mentor_id', auth()->id());
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
