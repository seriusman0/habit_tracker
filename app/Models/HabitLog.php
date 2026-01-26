<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HabitLog extends Model
{
    protected $fillable = [
        'habit_id',
        'date',
        'status',
    ];

    protected $guarded = [];

    public function student(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'student_id');
    }

    public function habit(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Habit::class);
    }
}
