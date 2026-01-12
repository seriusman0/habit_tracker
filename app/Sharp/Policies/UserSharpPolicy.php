<?php

namespace App\Sharp\Policies;

use Code16\Sharp\Auth\SharpEntityPolicy;

class UserSharpPolicy extends SharpEntityPolicy
{
    public function entity($user): bool
    {
        return $user->hasRole('admin');
    }

    public function view($user, $instanceId): bool
    {
        return $user->hasRole('admin');
    }

    public function update($user, $instanceId): bool
    {
        return $user->hasRole('admin');
    }

    public function create($user): bool
    {
        return $user->hasRole('admin');
    }

    public function delete($user, $instanceId): bool
    {
        return $user->hasRole('admin');
    }
}
