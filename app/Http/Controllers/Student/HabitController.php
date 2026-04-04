<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\Habit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class HabitController extends Controller
{
    public function toggle(Request $request, Habit $habit)
    {
        $userId = Auth::id();

        /** @var \App\Models\User|null $user */
        $user = Auth::user();

        $assignedHabit = $user ? $user->habits()->where('habit_id', $habit->id)->first() : null;
        $hasAssigned = (bool)$assignedHabit;

        // Validasi kepemilikan via pivot secara eksklusif
        if (!$hasAssigned) {
            abort(403);
        }

        // Ambil penentu frekuensi (Timpa nilai Pivot jika ada)
        $frequency = $assignedHabit ? ($assignedHabit->pivot->frequency ?? $habit->frequency) : $habit->frequency;

        // Aturan Periode Sentinel
        // Apabila Weekly -> Rekaman mengikat ke Tanggal Senin (Mulai Minggu Tersebut)
        $logDate = ($frequency === 'weekly')
            ? now()->startOfWeek(\Carbon\Carbon::MONDAY)->toDateString()
            : now()->toDateString();

        // Cari rekaman berdasarkan identifier (Senin / Hari ini)
        $log = $habit->logs()
            ->where('student_id', $userId)
            ->whereDate('log_date', $logDate)
            ->first();

        if ($log) {
            if ($request->has('status') && $request->input('status') !== 'none') {
                $status = $request->input('status');
                $log->update(['status' => $status, 'logged_at' => now()]);
            }
            else {
                $log->delete(); // Remove log (Belum diisi)
            }
        }
        else {
            if ($request->has('status') && $request->input('status') !== 'none') {
                $status = $request->input('status');
                $habit->logs()->create([
                    'student_id' => $userId,
                    'log_date' => $logDate,
                    'status' => $status,
                    'logged_at' => now(),
                ]);
            }
        }

        return back();
    }
}
