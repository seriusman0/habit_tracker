<?php

use App\Models\User;
use App\Models\Habit;

test('user has habits relationship', function () {
    $user = User::factory()->create();
    $habit = Habit::factory()->create(['user_id' => $user->id]);

    expect($user->habits)->toHaveCount(1)
        ->and($user->habits->first()->id)->toBe($habit->id);
});

test('user has many sent friend requests', function () {
    $user = User::factory()->create();
    $recipient = User::factory()->create();

    \App\Models\Friendship::create([
        'sender_id' => $user->id,
        'recipient_id' => $recipient->id,
        'status' => 'pending'
    ]);

    expect($user->sentFriendRequests)->toHaveCount(1);
});

test('user has many received friend requests', function () {
    $user = User::factory()->create();
    $sender = User::factory()->create();

    \App\Models\Friendship::create([
        'sender_id' => $sender->id,
        'recipient_id' => $user->id,
        'status' => 'pending'
    ]);

    expect($user->receivedFriendRequests)->toHaveCount(1);
});
