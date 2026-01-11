<?php

namespace App\Http\Controllers;

use App\Models\Habit;
use App\Models\HabitPermission;
use Illuminate\Http\Request;
use Inertia\Inertia;

class SocialController extends Controller
{
    public function index()
    {
        $userId = auth()->id();

        // Get habit IDs where I am a viewer
        $allowedHabitIds = HabitPermission::where('viewer_id', $userId)
            ->pluck('habit_id');

        $habits = Habit::whereIn('id', $allowedHabitIds)
            ->where('is_archived', false)
            ->with(['user', 'logs' => function ($query) {
                $query->where('date', now()->toDateString());
            }])
            ->get()
            ->map(function ($habit) {
                $habit->today_log = $habit->logs->firstWhere('date', now()->toDateString());
                return $habit;
            });

        return Inertia::render('Social/Index', [
            'habits' => $habits,
        ]);
    }
}
