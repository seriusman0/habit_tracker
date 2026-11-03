<?php
namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\Attendance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AttendanceController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate(['classroom_id'=>'required|exists:classrooms,id']);
        $user = Auth::user();
        if (! $user->classrooms()->where('classrooms.id',$validated['classroom_id'])->exists()) {
            return response()->json(['message'=>'Anda tidak terdaftar di kelas ini.'],403);
        }
        $a = Attendance::updateOrCreate(
            ['student_id'=>Auth::id(),'classroom_id'=>$validated['classroom_id'],'date'=>now()->toDateString()],
            ['status'=>'pending']
        );
        return response()->json(['message'=>'Kehadiran berhasil diajukan dan menunggu konfirmasi.','data'=>$a],201);
    }
}
