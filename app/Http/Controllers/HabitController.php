<?php

namespace App\Http\Controllers;

use App\Models\Habit;
use App\Models\HabitLog;
use Illuminate\Http\Request;
use Inertia\Inertia;

class HabitController extends Controller
{
    public function index()
    {
        $startDate = now()->subDays(6)->toDateString();
        $endDate = now()->toDateString();

        // Generate array of last 7 dates for the frontend
        $dates = collect();
        for ($i = 6; $i >= 0; $i--) {
            $date = now()->subDays($i);
            $dates->push([
                'date' => $date->toDateString(),
                'day' => $date->format('D'), // Mon, Tue...
                'is_today' => $date->isToday(),
            ]);
        }

        $habits = Habit::where('user_id', auth()->id())
            ->where('is_archived', false)
            ->with(['logs' => function ($query) use ($startDate, $endDate) {
                $query->whereBetween('date', [$startDate, $endDate]);
            }])
            ->get()
            ->map(function ($habit) {
                // Map logs to Key-Value pair [date => status] for O(1) lookup
                $habit->logs_keyed = $habit->logs->mapWithKeys(function ($log) {
                    return [$log->date->toDateString() => $log->status];
                });
                unset($habit->logs); // Clean up array form
                return $habit;
            });

        return Inertia::render('Habit/Index', [
            'habits' => $habits,
            'dates' => $dates, // Pass the date structure for columns
        ]);
    }

    public function create()
    {
        return Inertia::render('Habit/Create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'color' => 'required|string',
            'frequency' => 'required|in:daily,weekly',
        ]);

        $habit = $request->user()->habits()->create($validated);



        return redirect()->route('habits.index');
    }

    public function edit(Habit $habit)
    {
        if ($habit->user_id !== auth()->id()) {
            abort(403);
        }

        return Inertia::render('Habit/Edit', [
            'habit' => $habit,
        ]);
    }

    public function update(Request $request, Habit $habit)
    {
        // Add authorization check
        if ($habit->user_id !== auth()->id()) {
            abort(403);
        }

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'color' => 'required|string',
            'frequency' => 'required|in:daily,weekly',
        ]);

        $habit->update($validated);



        return redirect()->route('habits.index');
    }

    public function destroy(Habit $habit)
    {
        if ($habit->user_id !== auth()->id()) {
            abort(403);
        }

        $habit->delete();

        return redirect()->route('habits.index');
    }
}
