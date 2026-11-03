<?php
namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use App\Models\DailyReflection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReflectionController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate(['mood'=>'required|string|in:HAPPY,NEUTRAL,SAD','note'=>'nullable|string']);
        $r = DailyReflection::updateOrCreate(
            ['student_id'=>Auth::id(),'ref_date'=>now()->toDateString()],
            ['mood'=>$validated['mood'],'note'=>$validated['note'] ?? null]
        );
        return response()->json($r,201);
    }
}
