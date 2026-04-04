<?php

namespace App\Filament\Mentor\Pages;

use App\Models\Attendance;
use App\Models\Classroom;
use Filament\Pages\Page;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Concerns\InteractsWithTable;
use Filament\Tables\Contracts\HasTable;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;

class Presensi extends Page implements HasTable
{
    use InteractsWithTable;

    protected static ?string $navigationIcon = 'heroicon-o-check-badge';
    protected static ?string $navigationLabel = 'Presensi Siswa';
    protected static ?string $title = 'Presensi Hari Ini';
    protected static ?int $navigationSort = 2;

    protected static string $view = 'filament.mentor.pages.presensi';

    public function table(Table $table): Table
    {
        $mentorClassroomIds = Classroom::where('mentor_id', Auth::id())->pluck('id');

        return $table
            ->query(
                Attendance::query()
                    ->with(['student:id,name', 'classroom:id,name'])
                    ->whereIn('classroom_id', $mentorClassroomIds)
                    ->whereDate('date', now()->toDateString())
                    ->orderByRaw("FIELD(status, 'pending', 'accepted', 'rejected')")
                    ->orderBy('created_at', 'desc')
            )
            ->columns([
                Tables\Columns\TextColumn::make('student.name')
                    ->label('Nama Siswa')
                    ->searchable()
                    ->weight('medium'),

                Tables\Columns\TextColumn::make('classroom.name')
                    ->label('Kelas')
                    ->badge()
                    ->color('gray'),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Waktu Pengajuan')
                    ->time('H:i')
                    ->sortable(),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn(string $state): string => match ($state) {
                        'pending'  => 'Menunggu',
                        'accepted' => 'Hadir',
                        'rejected' => 'Ditolak',
                        default    => $state,
                    })
                    ->color(fn(string $state): string => match ($state) {
                        'pending'  => 'warning',
                        'accepted' => 'success',
                        'rejected' => 'danger',
                        default    => 'gray',
                    }),
            ])
            ->actions([
                Tables\Actions\Action::make('accept')
                    ->label('Hadir')
                    ->icon('heroicon-o-check-circle')
                    ->color('success')
                    ->requiresConfirmation()
                    ->modalHeading('Konfirmasi Kehadiran')
                    ->modalDescription('Tandai siswa ini sebagai hadir?')
                    ->modalSubmitActionLabel('Ya, Hadir')
                    ->action(fn(Attendance $record) => $record->update(['status' => 'accepted']))
                    ->hidden(fn(Attendance $record): bool => $record->status === 'accepted'),

                Tables\Actions\Action::make('reject')
                    ->label('Tolak')
                    ->icon('heroicon-o-x-circle')
                    ->color('danger')
                    ->requiresConfirmation()
                    ->modalHeading('Tolak Kehadiran')
                    ->modalDescription('Yakin ingin menolak kehadiran siswa ini?')
                    ->modalSubmitActionLabel('Ya, Tolak')
                    ->action(fn(Attendance $record) => $record->update(['status' => 'rejected']))
                    ->hidden(fn(Attendance $record): bool => $record->status === 'rejected'),
            ])
            ->emptyStateHeading('Belum ada pengajuan kehadiran')
            ->emptyStateDescription('Siswa di kelas Anda belum mengajukan kehadiran hari ini.')
            ->emptyStateIcon('heroicon-o-calendar-days')
            ->poll('30s');
    }
}
