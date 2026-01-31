<?php

namespace App\Filament\Mentor\Widgets;

use App\Models\Habit;
use App\Models\HabitCategory;
use App\Models\User;
use Filament\Widgets\Widget;
use Illuminate\Database\Eloquent\Model;
use Filament\Notifications\Notification;

class HabitAssignmentWidget extends Widget
{
    protected static string $view = 'filament.mentor.widgets.habit-assignment-widget';
    protected int | string | array $columnSpan = 'full';

    public ?Model $record = null; // This will hold the Classroom record

    public $students = [];
    public $categories = []; // Templates grouped by category

    public $selectedStudentId = null;
    public $selectedStudentHabits = [];

    public function mount()
    {
        // Load Templates (Habits that don't belong to a specific student)
        $this->loadTemplates();

        // If we are on a page with a record (Classroom), load its students
        if ($this->record && method_exists($this->record, 'students')) {
            $this->students = $this->record->students()
                ->role('student')
                ->get()
                ->map(function ($student) {
                    return [
                        'id' => $student->id,
                        'name' => $student->name,
                        'email' => $student->email,
                    ];
                })
                ->toArray();
        }
    }

    public function loadTemplates()
    {
        // Get habits that are "templates" (student_id is null)
        $this->categories = HabitCategory::with(['habits' => function ($query) {
            $query->whereNull('student_id');
        }])
            ->get()
            ->map(function ($category) {
                return [
                    'id' => $category->id,
                    'name' => $category->name,
                    'habits' => $category->habits->map(function ($habit) {
                        return [
                            'id' => $habit->id,
                            'title' => $habit->title,
                            'color' => $habit->color ?: '#4F46E5',
                            'frequency' => $habit->frequency,
                        ];
                    })->toArray()
                ];
            })
            ->toArray();
    }

    public function updatedSelectedStudentId()
    {
        $this->loadStudentHabits();
    }

    public function loadStudentHabits()
    {
        if (!$this->selectedStudentId) {
            $this->selectedStudentHabits = [];
            return;
        }

        $student = User::find($this->selectedStudentId);
        if ($student) {
            $this->selectedStudentHabits = $student->habits()
                ->with('category')
                ->latest('pivot_created_at')
                ->get()
                ->map(function ($habit) {
                    return [
                        'id' => $habit->id,
                        'title' => $habit->title,
                        'color' => ($habit->pivot->color ?? $habit->color) ?: '#4F46E5',
                        'frequency' => $habit->pivot->frequency ?? $habit->frequency,
                        'category_name' => $habit->category?->name ?? 'Uncategorized',
                        'is_assigned' => true,
                    ];
                })->toArray();
        } else {
            $this->selectedStudentHabits = [];
        }
    }

    public function assignHabit($habitId)
    {
        if (!$this->selectedStudentId) {
            Notification::make()->title('Please select a student first')->warning()->send();
            return;
        }

        $student = User::find($this->selectedStudentId);
        $habit = Habit::find($habitId);

        if (!$student || !$habit) return;

        // Check if already assigned
        if ($student->habits()->where('habit_id', $habitId)->exists()) {
            Notification::make()->title('Habit already assigned')->warning()->send();
            return;
        }

        // Attach
        $student->habits()->attach($habitId, [
            'color' => $habit->color,
            'frequency' => $habit->frequency,
            'is_active' => true,
        ]);

        Notification::make()->title('Habit assigned successfully')->success()->send();

        $this->loadStudentHabits();
    }

    public function removeHabit($habitId)
    {
        if (!$this->selectedStudentId) return;

        $student = User::find($this->selectedStudentId);

        if ($student) {
            $student->habits()->detach($habitId);
            Notification::make()->title('Habit unassigned')->success()->send();
            $this->loadStudentHabits();
        }
    }
}
