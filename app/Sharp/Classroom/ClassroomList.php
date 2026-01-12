<?php

namespace App\Sharp\Classroom;

use App\Models\Classroom;
use Code16\Sharp\EntityList\Fields\EntityListField;
use Code16\Sharp\EntityList\Fields\EntityListFieldsContainer;
use Code16\Sharp\EntityList\SharpEntityList;
use Illuminate\Contracts\Support\Arrayable;

class ClassroomList extends SharpEntityList
{
    public function buildList(EntityListFieldsContainer $fields): void
    {
        $fields
            ->addField(
                EntityListField::make('name')
                    ->setLabel('Name')
                    ->setSortable()
            );
    }

    public function getListData(): array|Arrayable
    {
        $classrooms = Classroom::query();

        if ($this->queryParams->hasSearch()) {
            foreach ($this->queryParams->searchWords() as $word) {
                $classrooms->where('name', 'like', "%$word%");
            }
        }

        if ($this->queryParams->sortedBy()) {
            $classrooms->orderBy($this->queryParams->sortedBy(), $this->queryParams->sortedDir());
        }

        return $this->transform(
            $classrooms->paginate(30),
            function (Classroom $classroom) {
                return [
                    'id' => $classroom->id,
                    'name' => $classroom->name,
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
}
