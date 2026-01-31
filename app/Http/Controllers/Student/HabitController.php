<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\Habit;
use App\Models\HabitCategory;
use Illuminate\Http\Request;

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

        $studentId = auth()->id();

        $categoryId = null;
        if ($request->filled('category_name')) {
            $category = HabitCategory::firstOrCreate(
                ['student_id' => $studentId, 'name' => $request->category_name],
                ['sort_order' => 0]
            );
            $categoryId = $category->id;
        }

        Habit::create([
            'student_id' => $studentId,
            'category_id' => $categoryId,
            'title' => $validated['title'],
            'is_active' => true,
        ]);

        return back();
    }

    public function toggle(Request $request, Habit $habit)
    {
        if ($habit->student_id !== auth()->id()) {
            abort(403);
        }

        $today = now()->toDateString();
        $log = $habit->logs()->whereDate('log_date', $today)->first();

        if ($log) {
            // Toggle Logic: If completed -> delete (reset). If failed -> delete? 
            // Text says "toggle record hari ini". Simple toggle: Done <-> Not Done (or Null).
            // Let's assume if it exists -> delete. If not exists -> create 'completed'.
            // Requirement says "ombol ✅ menandai done, tombol ❌ menandai not done".
            // So we might need specific status input.
            // Let's check request input 'status'.

            if ($request->has('status')) {
                $status = $request->input('status'); // 'completed' or 'failed' (skipped?)
                $log->update(['status' => $status, 'logged_at' => now()]);
            } else {
                // Toggle behavior if no status provided?
                $log->delete(); // Remove log
            }
        } else {
            $status = $request->input('status', 'completed');
            $habit->logs()->create([
                'student_id' => auth()->id(),
                'log_date' => $today,
                'status' => $status,
                'logged_at' => now(),
            ]);
        }

        return back();
    }
}
