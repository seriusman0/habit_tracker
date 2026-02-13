<?php

use App\Http\Controllers\Mentor\ClassroomController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth', 'verified', 'role:mentor'])->prefix('mentor')->name('mentor.')->group(function () {
    // API endpoints for Vue widget (using session auth)
    Route::get('/api/classrooms/{classroom}', [ClassroomController::class, 'show'])->name('api.classrooms.show');
    Route::post('/api/classrooms/{classroom}/assign', [ClassroomController::class, 'assignHabit'])->name('api.classrooms.assign');

    // My Habits (Replica of Student Feature)
    Route::get('/my-habits', [\App\Http\Controllers\Mentor\MyHabitController::class, 'index'])->name('my-habits.index');
    Route::post('/my-habits', [\App\Http\Controllers\Mentor\MyHabitController::class, 'store'])->name('my-habits.store');
    Route::post('/my-habits/{habit}/toggle', [\App\Http\Controllers\Mentor\MyHabitController::class, 'toggle'])->name('my-habits.toggle');
});
