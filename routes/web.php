<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::redirect('/', '/dashboard');

Route::get('/dashboard', function () {
    $user = auth()->user();
    if ($user->hasRole('admin')) {
        return redirect()->to('/admin');
    }
    if ($user->hasRole('mentor')) {
        return redirect()->route('mentor.dashboard');
    }
    if ($user->hasRole('student')) {
        return redirect()->route('student.dashboard');
    }
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::resource('habits', \App\Http\Controllers\HabitController::class);
    Route::post('/habits/{habit}/toggle/{date}', [\App\Http\Controllers\HabitLogController::class, 'toggle'])->name('habits.toggle');
});

require __DIR__ . '/auth.php';
require __DIR__ . '/admin.php';
require __DIR__ . '/mentor.php';
require __DIR__ . '/student.php';
