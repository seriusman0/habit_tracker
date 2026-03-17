<?php

namespace App\Filament\Mentor\Widgets;

use App\Models\Attendance;
use Filament\Widgets\Widget;
use Illuminate\Database\Eloquent\Model;
use Filament\Notifications\Notification;

class ClassroomAttendanceWidget extends Widget
{
    protected static string $view = 'filament.mentor.widgets.classroom-attendance-widget';
    protected int | string | array $columnSpan = 'full';

    public ?Model $record = null; // The Classroom record

    public $attendances = [];

    public function mount()
    {
        $this->loadAttendances();
    }

    public function loadAttendances()
    {
        /** @var \App\Models\Classroom|null $classroom */
        $classroom = $this->record;
        if ($classroom && $classroom->id) {
            $this->attendances = Attendance::with('student:id,name')
                ->where('classroom_id', $classroom->id)
                ->whereDate('date', now()->toDateString())
                ->get()
                ->toArray();
        }
    }

    public function updateStatus($attendanceId, $status)
    {
        $attendance = Attendance::find($attendanceId);
        
        if ($attendance && $attendance->classroom->mentor_id === auth()->id()) {
            $attendance->update(['status' => $status]);
            
            Notification::make()
                ->title('Status kehadiran diperbarui.')
                ->success()
                ->send();
                
            $this->loadAttendances();
        }
    }
}
