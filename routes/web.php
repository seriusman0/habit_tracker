<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::redirect('/', '/dashboard');

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::resource('habits', \App\Http\Controllers\HabitController::class);
    Route::post('/habits/{habit}/toggle/{date}', [\App\Http\Controllers\HabitLogController::class, 'toggle'])->name('habits.toggle');

    Route::resource('friendships', \App\Http\Controllers\FriendshipController::class);
    Route::get('/social', [\App\Http\Controllers\SocialController::class, 'index'])->name('social.index');
});

require __DIR__ . '/auth.php';
