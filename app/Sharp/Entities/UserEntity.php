<?php

namespace App\Sharp\Entities;

use App\Sharp\Users\UserForm;
use App\Sharp\Users\UserList;
use Code16\Sharp\Utils\Entities\SharpEntity;

class UserEntity extends SharpEntity
{
    protected string $label = 'User';
    protected ?string $list = UserList::class;
    protected ?string $form = UserForm::class;
    protected ?string $policy = \App\Sharp\Policies\UserSharpPolicy::class;

    protected array $prohibitedActions = [];
}
