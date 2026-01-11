<?php

namespace App\Http\Controllers;

use App\Models\Habit;
use App\Models\HabitLog;
use Illuminate\Http\Request;

class HabitLogController extends Controller
{
    public function toggle(Request $request, Habit $habit, $date)
    {
        if ($habit->user_id !== auth()->id()) {
            abort(403);
        }

        $log = $habit->logs()->whereDate('date', $date)->first();

        if (!$log) {
            // State 1 (Null) -> State 2 (Completed)
            $habit->logs()->create([
                'date' => $date,
                'status' => 'completed',
            ]);
        } elseif ($log->status === 'completed') {
            // State 2 (Completed) -> State 3 (Skipped)
            $log->update(['status' => 'skipped']);
        } else {
            // State 3 (Skipped) -> State 1 (Null/Delete)
            $log->delete();
        }

        return back();
    }
}
