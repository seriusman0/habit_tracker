<?php

namespace App\Filament\Resources;

use App\Filament\Resources\HabitLogResource\Pages;
use App\Models\HabitLog;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class HabitLogResource extends Resource
{
    protected static ?string $model = HabitLog::class;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-list';
    protected static ?string $navigationLabel = 'Log Kebiasaan';
    protected static ?string $navigationGroup = 'Administration';
    protected static ?int $navigationSort = 1;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('habit_id')
                    ->relationship('habit', 'title')
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\Select::make('student_id')
                    ->relationship('student', 'name', fn($query) => $query->role('student'))
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\DatePicker::make('log_date')
                    ->required(),
                Forms\Components\Select::make('status')
                    ->options([
                        'completed' => 'Selesai',
                        'skipped'   => 'Dilewati',
                        'failed'    => 'Gagal',
                    ])
                    ->required(),
                Forms\Components\DateTimePicker::make('logged_at'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->defaultSort('log_date', 'desc')
            ->columns([
                Tables\Columns\TextColumn::make('log_date')
                    ->label('Tanggal')
                    ->date('d M Y')
                    ->sortable(),
                Tables\Columns\TextColumn::make('student.name')
                    ->label('Siswa')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('habit.title')
                    ->label('Kebiasaan')
                    ->searchable(),
                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn(string $state): string => match ($state) {
                        'completed' => 'Selesai',
                        'skipped'   => 'Dilewati',
                        'failed'    => 'Gagal',
                        default     => $state,
                    })
                    ->color(fn(string $state): string => match ($state) {
                        'completed' => 'success',
                        'skipped'   => 'warning',
                        'failed'    => 'danger',
                        default     => 'gray',
                    }),
                Tables\Columns\TextColumn::make('logged_at')
                    ->label('Dicatat Pada')
                    ->dateTime('d M Y H:i')
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->options([
                        'completed' => 'Selesai',
                        'skipped'   => 'Dilewati',
                        'failed'    => 'Gagal',
                    ]),
                Tables\Filters\SelectFilter::make('student')
                    ->relationship('student', 'name')
                    ->label('Siswa'),
            ])
            ->actions([
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListHabitLogs::route('/'),
        ];
    }
}
