<?php

namespace App\Sharp\Entities;

use App\Sharp\Roles\RoleForm;
use App\Sharp\Roles\RoleList;
use App\Sharp\Policies\RoleSharpPolicy;
use Code16\Sharp\Utils\Entities\SharpEntity;

class RoleEntity extends SharpEntity
{
    protected string $label = 'Role';
    protected ?string $list = RoleList::class;
    protected ?string $form = RoleForm::class;
    protected ?string $policy = RoleSharpPolicy::class;
}
