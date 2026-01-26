<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::middleware(['auth', 'role:student'])->prefix('student')->name('student.')->group(function () {
    Route::get('/dashboard', [\App\Http\Controllers\Student\DashboardController::class, 'index'])->name('dashboard');
});
