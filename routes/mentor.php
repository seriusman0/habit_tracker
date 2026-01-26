<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::middleware(['auth', 'role:mentor'])->prefix('mentor')->name('mentor.')->group(function () {
    Route::get('/dashboard', [\App\Http\Controllers\Mentor\DashboardController::class, 'index'])->name('dashboard');
});
