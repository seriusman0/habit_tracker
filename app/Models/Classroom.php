<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Classroom extends Model
{
    protected $fillable = ['name', 'mentor_id', 'description', 'status'];

    public function mentor(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'mentor_id');
    }

    public function students(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        return $this->belongsToMany(User::class, 'class_memberships', 'class_id', 'student_id')
            ->withPivot(['status', 'assigned_by_admin_id', 'assigned_at', 'ended_at'])
            ->withTimestamps();
    }
}
