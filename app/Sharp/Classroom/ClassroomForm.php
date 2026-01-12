<?php

namespace App\Sharp\Classroom;

use App\Models\Classroom;
use App\Models\User;
use Code16\Sharp\Utils\Fields\FieldsContainer;
use Code16\Sharp\Form\Fields\SharpFormSelectField;
use Code16\Sharp\Form\Fields\SharpFormTextField;
use Code16\Sharp\Form\Layout\FormLayout;
use Code16\Sharp\Form\Layout\FormLayoutColumn;
use Code16\Sharp\Form\SharpForm;
use Illuminate\Database\Eloquent\Builder;

class ClassroomForm extends SharpForm
{
    public function buildFormFields(FieldsContainer $formFields): void
    {
        $formFields
            ->addField(
                SharpFormTextField::make('name')
                    ->setLabel('Class Name')
            )
            ->addField(
                SharpFormSelectField::make(
                    'teacher_id',
                    User::whereHas('roles', function (Builder $query) {
                        $query->where('name', 'teacher');
                    })->orderBy('name')->pluck('name', 'id')->toArray()
                )
                    ->setLabel('Teacher')
                    ->setDisplayAsDropdown()
            )
            ->addField(
                SharpFormSelectField::make(
                    'students',
                    User::whereHas('roles', function (Builder $query) {
                        $query->where('name', 'student');
                    })->orderBy('name')->pluck('name', 'id')->toArray()
                )
                    ->setLabel('Students')
                    ->setMultiple()
            );
    }

    public function buildFormLayout(FormLayout $formLayout): void
    {
        $formLayout
            ->addColumn(6, function (FormLayoutColumn $column) {
                $column->withSingleField('name')
                    ->withSingleField('teacher_id');
            })
            ->addColumn(6, function (FormLayoutColumn $column) {
                $column->withSingleField('students');
            });
    }

    public function find(mixed $id): array
    {
        return $this->transform(
            Classroom::with('students')->findOrFail($id),
            function (Classroom $classroom) {
                return [
                    'name' => $classroom->name,
                    'teacher_id' => $classroom->teacher_id,
                    'students' => $classroom->students->pluck('id')->toArray(),
                ];
            }
        );
    }

    public function update(mixed $id, array $data): mixed
    {
        $classroom = $id ? Classroom::findOrFail($id) : new Classroom();

        $this->save($classroom, $data);

        return $classroom->id;
    }

    public function delete(mixed $id): void
    {
        Classroom::findOrFail($id)->delete();
    }

    private function save(Classroom $classroom, array $data): void
    {
        $classroom->fill($data);
        $classroom->save();

        if (isset($data['students'])) {
            $classroom->students()->sync($data['students']);
        }
    }
}
