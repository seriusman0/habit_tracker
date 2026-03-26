<?php

namespace App\Filament\Mentor\Pages;

use Filament\Pages\Page;
use App\Models\Attendance;
use App\Models\Classroom;
use Filament\Notifications\Notification;
use Illuminate\Support\Facades\Log;

class Presensi extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-check-badge';
    protected static ?string $navigationLabel = 'Presensi Siswa';
    protected static ?string $title = 'Presensi Hari Ini';
    protected static ?int $navigationSort = 2;

    protected static string $view = 'filament.mentor.pages.presensi';

    public $attendances = [];

    public function mount()
    {
        $this->loadAttendances();
    }

    public function loadAttendances()
    {
        try {
            // Get all classrooms owned by this mentor
            $classroomIds = Classroom::where('mentor_id', \Illuminate\Support\Facades\Auth::id())->pluck('id');

            // Get today's attendance for those classrooms
            $this->attendances = Attendance::with(['student:id,name', 'classroom:id,name'])
                ->whereIn('classroom_id', $classroomIds)
                ->whereDate('date', now()->toDateString())
                ->orderBy('created_at', 'desc')
                ->get()
                ->toArray();
        } catch (\Exception $e) {
            // Fallback gracefully in case of missing columns in production or DB issues
            Log::error('Error loading attendances: ' . $e->getMessage());
            $this->attendances = [];
            
            Notification::make()
                ->title('Gagal memuat data presensi.')
                ->body('Pastikan Anda telah menjalankan migrate di server production.')
                ->danger()
                ->send();
        }
    }

    public function updateStatus($attendanceId, $status)
    {
        $attendance = Attendance::find($attendanceId);
        
        // Ensure classroom is not null in case it was softly or forcefully deleted without cascade
        if ($attendance && $attendance->classroom && $attendance->classroom->mentor_id === \Illuminate\Support\Facades\Auth::id()) {
            $attendance->update(['status' => $status]);
            
            Notification::make()
                ->title('Status kehadiran diperbarui.')
                ->success()
                ->send();
                
            $this->loadAttendances();
        } else {
            Notification::make()
                ->title('Aksi tidak diizinkan atau data tidak valid.')
                ->danger()
                ->send();
        }
    }
}
