<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\Habit;
use App\Models\HabitCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class HabitController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'category_name' => 'nullable|string|max:255', // Simplified: text input for category or select existing? Req says "Kategori"
            // For MVP, if they type a category name, find or create category.
            // Or simpler: just title and optional category_id if we have UI for it.
            // Requirement says: "Minimal: nama/label, kategori jika ada".
        ]);

        $studentId = Auth::id();

        $categoryId = null;
        if ($request->filled('category_name')) {
            $category = HabitCategory::firstOrCreate(
                ['name' => $request->category_name],
                ['created_by_user_id' => $studentId]
            );
            $categoryId = $category->id;
        }

        $habit = Habit::create([
            'category_id' => $categoryId,
            'title' => $validated['title'],
            'is_active' => true,
        ]);

        // Attach to pivot so it appears in the student's list
        /** @var \App\Models\User $user */
        if ($user = Auth::user()) {
            $user->habits()->attach($habit->id, [
                'is_active' => true,
                'frequency' => 'daily', // Default
                'color' => '#3b82f6', // Default blue
            ]);
        }

        return back();
    }

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
