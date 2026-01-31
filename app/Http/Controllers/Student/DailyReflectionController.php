<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\DailyReflection;
use Illuminate\Http\Request;

class DailyReflectionController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'mood' => 'required|string|in:HAPPY,NEUTRAL,SAD', // Mapping Senang/Biasa/Sedih
            'note' => 'nullable|string',
        ]);

        DailyReflection::updateOrCreate(
            [
                'student_id' => auth()->id(),
                'ref_date' => now()->toDateString(),
            ],
            [
                'mood' => $validated['mood'],
                'note' => $validated['note'],
            ]
        );

        return back();
    }
}
