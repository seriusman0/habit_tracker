<?php

use App\Models\User;
use App\Models\Friendship;

test('user can send friend request', function () {
    $sender = User::factory()->create();
    $recipient = User::factory()->create();

    $response = $this->actingAs($sender)
        ->post(route('friendships.store'), [
            'username' => $recipient->username
        ]);

    $response->assertRedirect();
    $this->assertDatabaseHas('friendships', [
        'sender_id' => $sender->id,
        'recipient_id' => $recipient->id,
        'status' => 'pending'
    ]);
});

test('user can accept friend request', function () {
    $sender = User::factory()->create();
    $recipient = User::factory()->create();

    $friendship = Friendship::create([
        'sender_id' => $sender->id,
        'recipient_id' => $recipient->id,
        'status' => 'pending'
    ]);

    $response = $this->actingAs($recipient)
        ->patch(route('friendships.update', $friendship), [
            'status' => 'accepted'
        ]);

    $this->assertDatabaseHas('friendships', [
        'id' => $friendship->id,
        'status' => 'accepted'
    ]);
});
