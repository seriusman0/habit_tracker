<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\Attendance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AttendanceController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'classroom_id' => 'required|exists:classrooms,id',
        ]);

        $studentId = Auth::id();
        $today = now()->toDateString();

        // Verify student belongs to this classroom
        /** @var \App\Models\User $user */
        $user = Auth::user();
        if (!$user->classrooms()->where('classrooms.id', $validated['classroom_id'])->exists()) {
            abort(403, 'Anda tidak terdaftar di kelas ini.');
        }

        // Create or update attendance to 'pending'
        Attendance::updateOrCreate(
            [
                'student_id' => $studentId,
                'classroom_id' => $validated['classroom_id'],
                'date' => $today,
            ],
            [
                'status' => 'pending',
            ]
        );

        return back()->with('success', 'Kehadiran berhasil diajukan dan menunggu konfirmasi.');
    }
}
