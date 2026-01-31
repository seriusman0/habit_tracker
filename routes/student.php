<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::middleware(['auth', 'role:student'])->prefix('student')->name('student.')->group(function () {
    Route::get('/', [\App\Http\Controllers\Student\DashboardController::class, 'index'])->name('dashboard');
    Route::redirect('/dashboard', '/student');

    // Profile
    Route::get('/profile', [\App\Http\Controllers\Student\ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [\App\Http\Controllers\Student\ProfileController::class, 'update'])->name('profile.update');

    // Friends
    Route::get('/friends', [\App\Http\Controllers\Student\FriendController::class, 'index'])->name('friends.index');

    Route::post('/habits', [\App\Http\Controllers\Student\HabitController::class, 'store'])->name('habits.store');
    Route::post('/habits/{habit}/toggle', [\App\Http\Controllers\Student\HabitController::class, 'toggle'])->name('habits.toggle');
    Route::post('/reflections', [\App\Http\Controllers\Student\DailyReflectionController::class, 'store'])->name('reflections.store');
});
