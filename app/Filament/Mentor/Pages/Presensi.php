<?php

namespace App\Filament\Mentor\Pages;

use Filament\Pages\Page;
use App\Models\Attendance;
use App\Models\Classroom;
use Filament\Notifications\Notification;

class Presensi extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-check-badge';
    protected static ?string $navigationLabel = 'Presensi Siswa';
    protected static ?string $title = 'Presensi Hari Ini';
    protected static ?int $navigationSort = 2; // Typically below dashboard

    protected static string $view = 'filament.mentor.pages.presensi';

    public $attendances = [];

    public function mount()
    {
        $this->loadAttendances();
    }

    public function loadAttendances()
    {
        // Get all classrooms owned by this mentor
        $classroomIds = Classroom::where('mentor_id', \Illuminate\Support\Facades\Auth::id())->pluck('id');

        // Get today's attendance for those classrooms
        $this->attendances = Attendance::with(['student:id,name', 'classroom:id,name'])
            ->whereIn('classroom_id', $classroomIds)
            ->whereDate('date', now()->toDateString())
            ->orderBy('created_at', 'desc')
            ->get()
            ->toArray();
    }

    public function updateStatus($attendanceId, $status)
    {
        $attendance = Attendance::find($attendanceId);
        
        if ($attendance && $attendance->classroom->mentor_id === \Illuminate\Support\Facades\Auth::id()) {
            $attendance->update(['status' => $status]);
            
            Notification::make()
                ->title('Status kehadiran diperbarui.')
                ->success()
                ->send();
                
            $this->loadAttendances();
        }
    }
}
