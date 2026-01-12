<?php

namespace App\Providers;

use Code16\Sharp\Config\SharpConfigBuilder;
use Code16\Sharp\SharpAppServiceProvider;
use App\Sharp\Entities\UserEntity;
use App\Sharp\Classroom\ClassroomEntity;
use App\Sharp\SharpMenu;

class SharpServiceProvider extends SharpAppServiceProvider
{
    protected function configureSharp(SharpConfigBuilder $config): void
    {
        $config
            ->setName('7 Kebiasaan Admin')
            ->addEntity('users', UserEntity::class)
            ->addEntity('roles', \App\Sharp\Entities\RoleEntity::class)
            ->addEntity('classrooms', ClassroomEntity::class)
            ->setSharpMenu(SharpMenu::class);
    }

    protected function declareAccessGate(): void
    {
        \Illuminate\Support\Facades\Gate::define('viewSharp', function ($user) {
            return $user->hasRole('admin');
        });
    }
}
