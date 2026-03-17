<?php

namespace App\Http\Controllers\Mentor;

use App\Http\Controllers\Controller;
use App\Models\Attendance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AttendanceController extends Controller
{
    public function updateStatus(Request $request, Attendance $attendance)
    {
        $validated = $request->validate([
            'status' => 'required|in:accepted,rejected',
        ]);

        // Authorization check: mentor must own the classroom
        $attendance->load('classroom');
        if ($attendance->classroom->mentor_id !== Auth::id()) {
            abort(403, 'Anda tidak memiliki akses ke kelas ini.');
        }

        $attendance->update([
            'status' => $validated['status'],
        ]);

        return back()->with('success', 'Status kehadiran berhasil diperbarui.');
    }
}
