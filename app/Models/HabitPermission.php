<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HabitPermission extends Model
{
    protected $fillable = [
        'habit_id',
        'viewer_id',
    ];

    public function habit()
    {
        return $this->belongsTo(Habit::class);
    }

    public function viewer()
    {
        return $this->belongsTo(User::class, 'viewer_id');
    }
}
