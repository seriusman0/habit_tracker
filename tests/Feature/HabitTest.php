<?php

use App\Models\User;
use App\Models\Habit;

beforeEach(function () {
    $this->user = User::factory()->create();
});

test('user can create a habit', function () {
    $response = $this->actingAs($this->user)
        ->post(route('habits.store'), [
            'title' => 'Drink Water',
            'description' => '2L a day',
            'color' => '#3B82F6',
            'frequency' => 'daily',
            'shared_with' => []
        ]);

    $response->assertRedirect(route('habits.index'));
    $this->assertDatabaseHas('habits', [
        'title' => 'Drink Water',
        'user_id' => $this->user->id
    ]);
});

test('user can view their own habits', function () {
    $habit = Habit::factory()->create(['user_id' => $this->user->id, 'title' => 'My Secret Habit']);
    \App\Models\HabitLog::create([
        'habit_id' => $habit->id,
        'date' => now()->toDateString(),
        'status' => 'completed'
    ]);

    $response = $this->actingAs($this->user)
        ->get(route('habits.index'));

    $response->assertOk()
        ->assertInertia(
            fn($page) => $page
                ->component('Habit/Index')
                ->has('habits', 1)
        );
});

test('user cannot edit another users habit (IDOR)', function () {
    $otherUser = User::factory()->create();
    $habit = Habit::factory()->create(['user_id' => $otherUser->id]);

    $response = $this->actingAs($this->user)
        ->put(route('habits.update', $habit), [
            'title' => 'Hacked Title',
            'color' => '#000000',
            'frequency' => 'daily'
        ]);

    $response->assertStatus(403);
    $this->assertDatabaseMissing('habits', ['title' => 'Hacked Title']);
});

test('user cannot delete another users habit (IDOR)', function () {
    $otherUser = User::factory()->create();
    $habit = Habit::factory()->create(['user_id' => $otherUser->id]);

    $response = $this->actingAs($this->user)
        ->delete(route('habits.destroy', $habit));

    $response->assertStatus(403);
    $this->assertDatabaseHas('habits', ['id' => $habit->id]);
});

test('toggle endpoint cycles status correctly', function () {
    $habit = Habit::factory()->create(['user_id' => $this->user->id]);
    $date = now()->toDateString();

    // Cycle 1: Null -> Completed
    $this->actingAs($this->user)
        ->post(route('habits.toggle', ['habit' => $habit->id, 'date' => $date]));

    $this->assertDatabaseHas('habit_logs', [
        'habit_id' => $habit->id,
        'status' => 'completed'
    ]);

    // Cycle 2: Completed -> Skipped
    $this->actingAs($this->user)
        ->post(route('habits.toggle', ['habit' => $habit->id, 'date' => $date]));

    $this->assertDatabaseHas('habit_logs', [
        'habit_id' => $habit->id,
        'status' => 'skipped'
    ]);

    // Cycle 3: Skipped -> Null (Delete)
    $this->actingAs($this->user)
        ->post(route('habits.toggle', ['habit' => $habit->id, 'date' => $date]));

    $this->assertDatabaseMissing('habit_logs', [
        'habit_id' => $habit->id,
        'date' => $date
    ]);
});
