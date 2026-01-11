<?php

namespace App\Http\Controllers;

use App\Models\Friendship;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;

class FriendshipController extends Controller
{
    public function index()
    {
        $userId = auth()->id();

        $friends = Friendship::where(function ($query) use ($userId) {
            $query->where('sender_id', $userId)
                ->orWhere('recipient_id', $userId);
        })
            ->where('status', 'accepted')
            ->with(['sender', 'recipient'])
            ->get()
            ->map(function ($friendship) use ($userId) {
                return $friendship->sender_id === $userId ? $friendship->recipient : $friendship->sender;
            });

        $requests = Friendship::where('recipient_id', $userId)
            ->where('status', 'pending')
            ->with('sender')
            ->get()
            ->map(function ($friendship) {
                $user = $friendship->sender;
                $user->friendship_id = $friendship->id;
                return $user;
            });

        $pendingSent = Friendship::where('sender_id', $userId)
            ->where('status', 'pending')
            ->with('recipient')
            ->get()
            ->map(function ($friendship) {
                $user = $friendship->recipient;
                $user->friendship_id = $friendship->id;
                return $user;
            });

        return Inertia::render('Friend/Index', [
            'friends' => $friends,
            'requests' => $requests,
            'pendingSent' => $pendingSent,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'username' => 'required|string|exists:users,username',
        ]);

        $recipient = User::where('username', $validated['username'])->first();
        $senderId = auth()->id();

        if ($recipient->id === $senderId) {
            return back()->withErrors(['username' => 'You cannot add yourself.']);
        }

        // Check existing friendship
        $exists = Friendship::where(function ($query) use ($senderId, $recipient) {
            $query->where('sender_id', $senderId)->where('recipient_id', $recipient->id);
        })->orWhere(function ($query) use ($senderId, $recipient) {
            $query->where('sender_id', $recipient->id)->where('recipient_id', $senderId);
        })->exists();

        if ($exists) {
            return back()->withErrors(['username' => 'Friendship request already pending or accepted.']);
        }

        Friendship::create([
            'sender_id' => $senderId,
            'recipient_id' => $recipient->id,
            'status' => 'pending',
        ]);

        return back();
    }

    public function update(Request $request, Friendship $friendship)
    {
        if ($friendship->recipient_id !== auth()->id()) {
            abort(403);
        }

        $friendship->update(['status' => 'accepted']);

        return back();
    }

    public function destroy(Friendship $friendship)
    {
        if ($friendship->sender_id !== auth()->id() && $friendship->recipient_id !== auth()->id()) {
            abort(403);
        }

        $friendship->delete();

        return back();
    }
}
