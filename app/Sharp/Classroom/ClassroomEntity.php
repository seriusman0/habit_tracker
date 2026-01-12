<?php

namespace App\Sharp\Classroom;

use App\Models\Classroom;
use App\Policies\ClassroomPolicy;
use Code16\Sharp\Utils\Entities\SharpEntity;

class ClassroomEntity extends SharpEntity
{
    protected string $label = 'Classroom';
    protected ?string $list = ClassroomList::class;
    protected ?string $form = ClassroomForm::class;
    protected ?string $policy = \App\Sharp\Policies\ClassroomSharpPolicy::class;
}
