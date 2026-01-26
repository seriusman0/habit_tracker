<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Habit extends Model
{
    use HasFactory;

    protected $fillable = [
        'student_id',
        'category_id',
        'title',
        'description',
        'target_time',
        'color',
        'frequency',
        'is_active',
        'sort_order',
        'created_by_user_id',
        'updated_by_user_id',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function student(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'student_id');
    }

    public function category(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(HabitCategory::class, 'category_id');
    }

    public function logs(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(HabitLog::class);
    }
}
