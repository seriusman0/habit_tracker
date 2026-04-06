<?php

namespace App\Filament\Resources;

use App\Filament\Resources\MentorResource\Pages;
use App\Models\Habit;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class MentorResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $slug = 'mentor';

    protected static ?string $modelLabel = 'Mentor';

    protected static ?string $navigationIcon = 'heroicon-o-users';
    protected static ?string $navigationGroup = 'User Management';
    protected static ?int $navigationSort = 1;

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
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('username')
                    ->searchable(),
                Tables\Columns\TextColumn::make('email')
                    ->searchable(),
                Tables\Columns\TextColumn::make('mentorClassrooms_count')
                    ->counts('mentorClassrooms')
                    ->label('Kelas'),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\Action::make('assignDefaultHabitsToStudents')
                    ->label('Assign Default ke Siswa')
                    ->icon('heroicon-o-sparkles')
                    ->color('success')
                    ->requiresConfirmation()
                    ->modalHeading(fn(User $record) => "Assign Default Habit ke Siswa {$record->name}")
                    ->modalDescription('Semua habit aktif yang belum ada akan ditambahkan ke seluruh siswa di kelas mentor ini.')
                    ->modalSubmitActionLabel('Ya, Assign')
                    ->action(function (User $record): void {
                        $classroomIds = $record->mentorClassrooms()->pluck('id');

                        if ($classroomIds->isEmpty()) {
                            Notification::make()
                                ->title('Tidak ada kelas')
                                ->body('Mentor ini belum memiliki kelas.')
                                ->warning()
                                ->send();
                            return;
                        }

                        $students = User::role('student')
                            ->whereHas('classrooms', fn(Builder $q) => $q->whereIn('classrooms.id', $classroomIds))
                            ->get();

                        if ($students->isEmpty()) {
                            Notification::make()
                                ->title('Tidak ada siswa')
                                ->body('Belum ada siswa di kelas mentor ini.')
                                ->warning()
                                ->send();
                            return;
                        }

                        $students->each->assignDefaultHabits();

                        Notification::make()
                            ->title('Berhasil')
                            ->body("Habit default berhasil ditambahkan ke {$students->count()} siswa.")
                            ->success()
                            ->send();
                    }),

                Tables\Actions\Action::make('assignCustomHabitToStudent')
                    ->label('Assign Custom ke Siswa')
                    ->icon('heroicon-o-plus-circle')
                    ->color('info')
                    ->modalHeading(fn(User $record) => "Assign Habit Custom — Siswa dari {$record->name}")
                    ->form([
                        Forms\Components\Select::make('student_id')
                            ->label('Siswa')
                            ->options(fn(User $record) => User::role('student')
                                ->whereHas(
                                    'classrooms',
                                    fn(Builder $q) => $q->whereIn(
                                        'classrooms.id',
                                        $record->mentorClassrooms()->pluck('id')
                                    )
                                )
                                ->pluck('name', 'id')
                            )
                            ->required()
                            ->searchable()
                            ->placeholder('Pilih siswa...'),

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
                    ->action(function (array $data): void {
                        $student = User::find($data['student_id']);

                        if (!$student) {
                            Notification::make()->title('Siswa tidak ditemukan')->danger()->send();
                            return;
                        }

                        if ($student->habits()->where('habit_id', $data['habit_id'])->exists()) {
                            Notification::make()
                                ->title('Habit sudah ada')
                                ->body("{$student->name} sudah memiliki habit tersebut.")
                                ->warning()
                                ->send();
                            return;
                        }

                        $student->habits()->attach($data['habit_id'], [
                            'color'     => $data['color'],
                            'frequency' => $data['frequency'],
                            'is_active' => true,
                        ]);

                        Notification::make()
                            ->title('Berhasil')
                            ->body("Habit berhasil ditambahkan ke {$student->name}.")
                            ->success()
                            ->send();
                    }),

                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()->whereHas('roles', function ($query) {
            $query->where('name', 'mentor');
        });
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ManageMentors::route('/'),
        ];
    }
}
