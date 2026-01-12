<?php

namespace App\Sharp;

use App\Sharp\Classroom\ClassroomEntity;
use App\Sharp\Entities\UserEntity;
use Code16\Sharp\Utils\Menu\SharpMenu as BaseSharpMenu;

class SharpMenu extends BaseSharpMenu
{
    public function build(): self
    {
        return $this
            ->addSection('Access Management', function ($section) {
                $section
                    ->addEntityLink('users', 'Users', 'fa fa-users')
                    ->addEntityLink('roles', 'Roles', 'fa fa-lock');
            })
            ->addEntityLink('classrooms', 'Classrooms', 'fa fa-graduation-cap');
    }
}
