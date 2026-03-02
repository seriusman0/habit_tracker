<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;

class FriendController extends Controller
{
    public function index(Request $request, \App\Services\WeeklySummaryService $summaryService)
    {
        $user = auth()->user();

        // Ambil daftar Classmates tanpa N+1 (Paginasi Server-side)
        // Kumpulkan array ID Student
        $classmateIds = $user->classrooms()
            ->with('students')
            ->get()
            ->pluck('students')
            ->flatten()
            ->pluck('id')
            ->unique()
            ->reject(fn($id) => $id === $user->id)
            ->values();

        $search = $request->input('search');

        $friendsPaginator = User::whereIn('id', $classmateIds)
            ->select('id', 'name', 'email')
            ->when($search, function ($query, $search) {
            $query->where(function ($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%");
                }
                );
            })
            ->paginate(20)
            ->withQueryString();

        // Kumpulkan ID dari item paginasi yang sedang aktif di halaman ini saja
        $paginatedIds = $friendsPaginator->getCollection()->pluck('id');

        // Tarik ringkasan agregasi melalui Service
        $summaries = $summaryService->getWeeklySummariesForStudents($paginatedIds);

        // Sisipkan summary ke dalam collection user
        $friendsPaginator->getCollection()->transform(function ($friend) use ($summaries) {
            $friend->weekly_summary = $summaries[$friend->id] ?? null;
            return $friend;
        });

        return Inertia::render('Student/Friends', [
            'friends' => $friendsPaginator,
            'filters' => $request->only(['search']),
        ]);
    }
}
