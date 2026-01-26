<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DailyReflection extends Model
{
    protected $fillable = [
        'student_id',
        'ref_date',
        'mood',
        'note',
    ];

    public function student(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'student_id');
    }
}
