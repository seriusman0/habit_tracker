<?php

namespace App\Sharp\Users;

use App\Models\User;
use Code16\Sharp\EntityList\Fields\EntityListField;
use Code16\Sharp\EntityList\Fields\EntityListFieldsContainer;
use Code16\Sharp\EntityList\SharpEntityList;
use Illuminate\Contracts\Support\Arrayable;
use Illuminate\Database\Eloquent\Builder;

class UserList extends SharpEntityList
{
    public function buildList(EntityListFieldsContainer $fields): void
    {
        $fields
            ->addField(
                EntityListField::make('name')
                    ->setLabel('Name')
                    ->setSortable()
            )
            ->addField(
                EntityListField::make('email')
                    ->setLabel('Email')
                    ->setSortable()
            )
            ->addField(
                EntityListField::make('roles')
                    ->setLabel('Roles')
            );
    }

    public function getListData(): array|Arrayable
    {
        $users = User::query()
            ->with('roles')
            ->when(
                $this->queryParams->filterFor(RoleFilter::class),
                function (Builder $query, $roleId) {
                    $query->whereHas('roles', function ($q) use ($roleId) {
                        $q->where('id', $roleId);
                    });
                }
            );

        if ($this->queryParams->hasSearch()) {
            foreach ($this->queryParams->searchWords() as $word) {
                $users->where(function ($query) use ($word) {
                    $query->where('name', 'like', "%$word%")
                        ->orWhere('email', 'like', "%$word%");
                });
            }
        }

        if ($this->queryParams->sortedBy()) {
            $users->orderBy($this->queryParams->sortedBy(), $this->queryParams->sortedDir());
        }

        return $this->transform(
            $users->paginate(30),
            function (User $user) {
                return [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'roles' => $user->roles->pluck('name')->implode(', '),
                ];
            }
        );
    }

    public function buildListConfig(): void
    {
        $this->configureSearchable()
            ->configureDefaultSort('name', 'asc')
            ->configurePaginated();
    }

    public function getFilters(): ?array
    {
        return [
            RoleFilter::class,
        ];
    }
}
