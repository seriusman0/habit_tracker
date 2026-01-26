<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MentorFeedback extends Model
{
    protected $fillable = [
        'class_id',
        'mentor_id',
        'student_id',
        'feedback_date',
        'message',
    ];

    public function classroom(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Classroom::class, 'class_id');
    }

    public function mentor(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'mentor_id');
    }

    public function student(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'student_id');
    }
}
