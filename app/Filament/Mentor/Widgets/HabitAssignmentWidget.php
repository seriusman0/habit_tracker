<?php

namespace App\Filament\Mentor\Widgets;

use App\Models\Habit;
use App\Models\HabitCategory;
use App\Models\User;
use Filament\Widgets\Widget;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;

class HabitAssignmentWidget extends Widget
{
    protected static string $view = 'filament.mentor.widgets.habit-assignment-widget';
    protected int | string | array $columnSpan = 'full';

    public ?int $classrowId = null;
    public $students = [];
    public $categories = [];

    // This property will be passed from the Action
    public $record = null;

    public $selectedStudentId = null;
    public $selectedStudentHabits = [];

    public function mount()
    {
        // Load Templates (Habits that don't belong to a specific student, or belong to admin/mentor as templates)
        // For this MVP, we'll assume "Templates" are habits created by the current user (Mentor) but with NULL student_id
        // OR we can just pick from a list of predefined habits if they exist.
        // Let's go with: Templates are habits where student_id is NULL.

        $this->loadData();
    }

    public function loadData()
    {
        $this->categories = HabitCategory::with(['habits' => function ($query) {
            // Fetch habits that act as templates (student_id is null)
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
                            'color' => $habit->color,
                            'frequency' => $habit->frequency,
                        ];
                    })->toArray()
                ];
            })
            ->toArray();

        // If record (Classroom) is passed, get students
        if ($this->record) {
            $this->students = $this->record->students()->get()->map(function ($student) {
                return [
                    'id' => $student->id,
                    'name' => $student->name,
                    'email' => $student->email,
                    'avatar' => $student->getFilamentAvatarUrl(), // Helper if exists, or null
                    'habits_count' => $student->habits()->count(),
                ];
            })->toArray();
        }
    }

    public function assignHabit($templateId, $studentId)
    {
        $template = Habit::find($templateId);
        $student = User::find($studentId);

        if (!$template || !$student) {
            return;
        }

        // Check for duplication
        $exists = Habit::where('student_id', $student->id)
            ->where('title', $template->title)
            ->where('category_id', $template->category_id)
            ->exists();

        if ($exists) {
            $this->dispatch('habit-assignment-failed', message: "Habit '{$template->title}' already assigned to {$student->name}");
            // We can also use Filament notification if preferred, but dispatch works for custom frontend feedback
            \Filament\Notifications\Notification::make()
                ->title('Duplicate Habit')
                ->body("Habit '{$template->title}' is already assigned to {$student->name}.")
                ->warning()
                ->send();
            return;
        }

        // Create new habit for the student based on template
        Habit::create([
            'student_id' => $student->id,
            'title' => $template->title,
            'description' => $template->description,
            'category_id' => $template->category_id,
            'color' => $template->color,
            'frequency' => $template->frequency,
            'is_active' => true,
            'created_by_user_id' => Auth::id(),
        ]);

        $this->dispatch('habit-assigned', message: "Assigned '{$template->title}' to {$student->name}");

        // Refresh data to update counts if needed
        $this->loadData();

        // If the assigned student is currently selected, refresh their habits list
        if ($this->selectedStudentId == $studentId) {
            $this->selectStudent($studentId);
        }
    }

    public function selectStudent($studentId)
    {
        $this->selectedStudentId = $studentId;
        $student = User::find($studentId);

        if ($student) {
            $this->selectedStudentHabits = $student->habits()
                ->with('category')
                ->latest()
                ->get()
                ->map(function ($habit) {
                    return [
                        'id' => $habit->id,
                        'title' => $habit->title,
                        'color' => $habit->color,
                        'frequency' => $habit->frequency,
                        'category_name' => $habit->category?->name ?? 'Uncategorized',
                    ];
                })->toArray();
        } else {
            $this->selectedStudentHabits = [];
        }
    }
}
