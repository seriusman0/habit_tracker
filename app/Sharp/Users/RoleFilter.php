<?php

namespace App\Sharp\Users;

use Code16\Sharp\EntityList\Filters\EntityListSelectFilter;
use Spatie\Permission\Models\Role;

class RoleFilter extends EntityListSelectFilter
{
    public function buildFilterConfig(): void
    {
        $this->configureLabel('Role');
    }

    public function values(): array
    {
        return Role::orderBy('name')
            ->pluck('name', 'id')
            ->toArray();
    }
}
