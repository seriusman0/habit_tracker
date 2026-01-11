<?php

use App\Models\User;
use App\Models\Habit;
use App\Models\Friendship;
use App\Models\HabitPermission;
use Inertia\Testing\AssertableInertia as Assert;

test('Scenario A: User B cannot see User As private habit', function () {
    $userA = User::factory()->create();
    $userB = User::factory()->create();

    // They are friends
    Friendship::create([
        'sender_id' => $userA->id,
        'recipient_id' => $userB->id,
        'status' => 'accepted'
    ]);

    // Private habit (no permissions data)
    Habit::factory()->create([
        'user_id' => $userA->id,
        'title' => 'Private Habit'
    ]);

    // User B checks social feed
    $response = $this->actingAs($userB)
        ->get(route('social.index'));

    $response->assertOk()
        ->assertInertia(
            fn(Assert $page) => $page
                ->component('Social/Index')
                ->has('habits', 0) // Should be empty
        );
});

test('Scenario B: User B can see User As shared habit', function () {
    $userA = User::factory()->create();
    $userB = User::factory()->create();

    // Habit
    $habit = Habit::factory()->create([
        'user_id' => $userA->id,
        'title' => 'Public Habit'
    ]);

    // Share it with B
    HabitPermission::create([
        'habit_id' => $habit->id,
        'viewer_id' => $userB->id
    ]);

    // User B checks feed
    $response = $this->actingAs($userB)
        ->get(route('social.index'));

    $response->assertOk()
        ->assertInertia(
            fn(Assert $page) => $page
                ->has('habits', 1)
                ->where('habits.0.title', 'Public Habit')
        );
});

test('Scenario C: User C cannot see habit shared only with User B', function () {
    $userA = User::factory()->create();
    $userB = User::factory()->create();
    $userC = User::factory()->create();

    // Habit
    $habit = Habit::factory()->create([
        'user_id' => $userA->id,
        'title' => 'Shared with B only'
    ]);

    // Share with B only
    HabitPermission::create([
        'habit_id' => $habit->id,
        'viewer_id' => $userB->id
    ]);

    // User C checks feed
    $response = $this->actingAs($userC)
        ->get(route('social.index'));

    $response->assertOk()
        ->assertInertia(
            fn(Assert $page) => $page
                ->has('habits', 0)
        );
});
