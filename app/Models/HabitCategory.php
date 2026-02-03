<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HabitCategory extends Model
{
    protected $fillable = [
        'name',
        'created_by_user_id',
        'updated_by_user_id',
    ];

    public function habits(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(Habit::class, 'category_id');
    }
}
