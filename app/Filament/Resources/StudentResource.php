<?php

namespace App\Filament\Resources;

use App\Filament\Resources\StudentResource\Pages;
use App\Models\Habit;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;

class StudentResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $slug = 'student';

    protected static ?string $modelLabel = 'Student';

    protected static ?string $navigationIcon = 'heroicon-o-academic-cap';
    protected static ?string $navigationGroup = 'User Management';
    protected static ?int $navigationSort = 2;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('username')
                    ->required()
                    ->unique(ignoreRecord: true)
                    ->maxLength(255),
                Forms\Components\TextInput::make('email')
                    ->email()
                    ->required()
                    ->unique(ignoreRecord: true)
                    ->maxLength(255),
                Forms\Components\TextInput::make('password')
                    ->password()
                    ->dehydrated(fn($state) => filled($state))
                    ->required(fn(string $context): bool => $context === 'create')
                    ->maxLength(255),

                Forms\Components\Select::make('genetic_type_id')
                    ->relationship('geneticType', 'name')
                    ->searchable()
                    ->preload()
                    ->createOptionForm([
                        Forms\Components\TextInput::make('name')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\Textarea::make('description')
                            ->maxLength(65535),
                    ])
                    ->required(),

                Forms\Components\Section::make('Student Profile')
                    ->relationship('studentProfile')
                    ->schema([
                        Forms\Components\DatePicker::make('birth_date')
                            ->required(),
                        Forms\Components\TextInput::make('school_name')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\TextInput::make('school_address')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\TextInput::make('grade_level')
                            ->numeric()
                            ->required(),
                        Forms\Components\Select::make('school_level')
                            ->options([
                                'SD' => 'SD',
                                'SMP' => 'SMP',
                                'SMA' => 'SMA',
                            ])
                            ->required(),
                        Forms\Components\TextInput::make('guardian_name')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\TextInput::make('guardian_phone')
                            ->tel()
                            ->required()
                            ->maxLength(255),
                    ]),
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
                    ->searchable(),
                Tables\Columns\TextColumn::make('habits_count')
                    ->counts('habits')
                    ->label('Habit')
                    ->sortable()
                    ->badge()
                    ->color(fn(int $state): string => $state === 0 ? 'danger' : 'success'),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\Action::make('assignDefaultHabits')
                    ->label('Assign Default')
                    ->icon('heroicon-o-sparkles')
                    ->color('success')
                    ->requiresConfirmation()
                    ->modalHeading('Assign Semua Default Habit')
                    ->modalDescription(fn(User $record) => "Semua habit aktif yang belum dimiliki {$record->name} akan ditambahkan.")
                    ->modalSubmitActionLabel('Ya, Assign')
                    ->action(function (User $record): void {
                        $record->assignDefaultHabits();
                        Notification::make()
                            ->title('Berhasil')
                            ->body("Habit default berhasil ditambahkan ke {$record->name}.")
                            ->success()
                            ->send();
                    }),

                Tables\Actions\Action::make('assignCustomHabit')
                    ->label('Assign Custom')
                    ->icon('heroicon-o-plus-circle')
                    ->color('info')
                    ->modalHeading('Assign Habit Custom ke Siswa')
                    ->form([
                        Forms\Components\Select::make('habit_id')
                            ->label('Habit')
                            ->options(fn() => Habit::where('is_active', true)
                                ->with('category')
                                ->get()
                                ->groupBy(fn($h) => $h->category?->name ?? 'Lainnya')
                                ->map(fn($habits) => $habits->pluck('title', 'id'))
                                ->toArray()
                            )
                            ->required()
                            ->searchable()
                            ->live()
                            ->afterStateUpdated(function (?int $state, Forms\Set $set): void {
                                if ($state) {
                                    $habit = Habit::find($state);
                                    if ($habit) {
                                        $set('color', $habit->color);
                                        $set('frequency', $habit->frequency);
                                    }
                                }
                            }),
                        Forms\Components\ColorPicker::make('color')
                            ->label('Warna')
                            ->required(),
                        Forms\Components\Select::make('frequency')
                            ->label('Frekuensi')
                            ->options([
                                'daily'  => 'Harian',
                                'weekly' => 'Mingguan',
                            ])
                            ->required(),
                    ])
                    ->action(function (User $record, array $data): void {
                        if ($record->habits()->where('habit_id', $data['habit_id'])->exists()) {
                            Notification::make()
                                ->title('Habit sudah ada')
                                ->body('Siswa ini sudah memiliki habit tersebut.')
                                ->warning()
                                ->send();
                            return;
                        }

                        $record->habits()->attach($data['habit_id'], [
                            'color'     => $data['color'],
                            'frequency' => $data['frequency'],
                            'is_active' => true,
                        ]);

                        Notification::make()
                            ->title('Berhasil')
                            ->body("Habit berhasil ditambahkan ke {$record->name}.")
                            ->success()
                            ->send();
                    }),

                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\BulkAction::make('assignDefaultHabitsBulk')
                        ->label('Assign Default Habit')
                        ->icon('heroicon-o-sparkles')
                        ->color('success')
                        ->requiresConfirmation()
                        ->modalHeading('Assign Default Habit ke Siswa Terpilih')
                        ->modalDescription('Semua habit aktif yang belum ada akan ditambahkan ke siswa yang dipilih.')
                        ->modalSubmitActionLabel('Ya, Assign')
                        ->action(function (Collection $records): void {
                            $records->each->assignDefaultHabits();
                            Notification::make()
                                ->title('Berhasil')
                                ->body("Habit default berhasil ditambahkan ke {$records->count()} siswa.")
                                ->success()
                                ->send();
                        })
                        ->deselectRecordsAfterCompletion(),
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()->whereHas('roles', function ($query) {
            $query->where('name', 'student');
        });
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ManageStudents::route('/'),
        ];
    }
}
