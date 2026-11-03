<?php
namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\Habit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class HabitController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $habits = $user->habits()->with('category')->get();
        return response()->json($habits);
    }

    public function toggle(Request $request, Habit $habit)
    {
        $userId = Auth::id();
        $user = Auth::user();
        $assigned = $user->habits()->where('habit_id', $habit->id)->first();
        if (! $assigned) {
            return response()->json(['message'=>'Forbidden'],403);
        }
        $frequency = $assigned->pivot->frequency ?? $habit->frequency;
        $logDate = ($frequency === 'weekly')
            ? now()->startOfWeek(\Carbon\Carbon::MONDAY)->toDateString()
            : now()->toDateString();

        $log = $habit->logs()->where('student_id',$userId)->whereDate('log_date',$logDate)->first();
        $status = $request->input('status');
        if ($log) {
            if ($request->has('status') && $status !== 'none') {
                $log->update(['status'=>$status,'logged_at'=>now()]);
            } else {
                $log->delete();
            }
        } else {
            if ($request->has('status') && $status !== 'none') {
                $habit->logs()->create(['student_id'=>$userId,'log_date'=>$logDate,'status'=>$status,'logged_at'=>now()]);
            }
        }
        return response()->json(['message'=>'ok']);
    }
}
