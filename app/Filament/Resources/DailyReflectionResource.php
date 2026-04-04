<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DailyReflectionResource\Pages;
use App\Models\DailyReflection;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class DailyReflectionResource extends Resource
{
    protected static ?string $model = DailyReflection::class;

    protected static ?string $navigationIcon = 'heroicon-o-face-smile';
    protected static ?string $navigationLabel = 'Refleksi Harian';
    protected static ?string $navigationGroup = 'Administration';
    protected static ?int $navigationSort = 2;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('student_id')
                    ->relationship('student', 'name', fn($query) => $query->role('student'))
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\DatePicker::make('ref_date')
                    ->label('Tanggal Refleksi')
                    ->required()
                    ->default(now()),
                Forms\Components\Select::make('mood')
                    ->label('Mood')
                    ->options([
                        'HAPPY'   => '😊 Senang',
                        'NEUTRAL' => '😐 Biasa',
                        'SAD'     => '😔 Sedih',
                    ])
                    ->required(),
                Forms\Components\Textarea::make('note')
                    ->label('Catatan')
                    ->columnSpanFull(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->defaultSort('ref_date', 'desc')
            ->columns([
                Tables\Columns\TextColumn::make('ref_date')
                    ->label('Tanggal')
                    ->date('d M Y')
                    ->sortable(),
                Tables\Columns\TextColumn::make('student.name')
                    ->label('Siswa')
                    ->searchable(),
                Tables\Columns\TextColumn::make('mood')
                    ->label('Mood')
                    ->badge()
                    ->formatStateUsing(fn(string $state): string => match ($state) {
                        'HAPPY'   => '😊 Senang',
                        'NEUTRAL' => '😐 Biasa',
                        'SAD'     => '😔 Sedih',
                        default   => $state,
                    })
                    ->color(fn(string $state): string => match ($state) {
                        'HAPPY'   => 'success',
                        'NEUTRAL' => 'warning',
                        'SAD'     => 'danger',
                        default   => 'gray',
                    }),
                Tables\Columns\TextColumn::make('note')
                    ->label('Catatan')
                    ->limit(60)
                    ->tooltip(fn($record) => $record->note),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('mood')
                    ->options([
                        'HAPPY'   => 'Senang',
                        'NEUTRAL' => 'Biasa',
                        'SAD'     => 'Sedih',
                    ]),
                Tables\Filters\SelectFilter::make('student')
                    ->relationship('student', 'name')
                    ->label('Siswa'),
            ])
            ->actions([]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDailyReflections::route('/'),
        ];
    }
}
