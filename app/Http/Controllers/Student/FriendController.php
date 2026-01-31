<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;

class FriendController extends Controller
{
    public function index()
    {
        $user = auth()->user();

        // For now, get all students in the same classes as "friends"
        // This is a placeholder logic as "Friendship" wasn't explicitly defined in the schema
        // We assume classmates = friends for this MVP context
        $classmateIds = $user->classrooms()
            ->with('students')
            ->get()
            ->pluck('students')
            ->flatten()
            ->pluck('id')
            ->unique()
            ->reject(fn($id) => $id === $user->id)
            ->values();

        $friends = User::whereIn('id', $classmateIds)
            ->select('id', 'name', 'email') // Add avatar if avail
            ->get();

        return Inertia::render('Student/Friends', [
            'friends' => $friends
        ]);
    }
}
