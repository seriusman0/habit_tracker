<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\HabitController;
use App\Http\Controllers\Api\ReflectionController;
use App\Http\Controllers\Api\AttendanceController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);

    Route::get('/habits', [HabitController::class, 'index']);
    Route::post('/habits/{habit}/toggle', [HabitController::class, 'toggle']);

    Route::post('/reflections', [ReflectionController::class, 'store']);

    Route::post('/attendances', [AttendanceController::class, 'store']);
});
