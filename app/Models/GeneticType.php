<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GeneticType extends Model
{
    protected $fillable = ['name', 'description'];

    public function users(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(User::class);
    }
}
