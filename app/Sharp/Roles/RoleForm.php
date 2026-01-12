<?php

namespace App\Sharp\Roles;

use Spatie\Permission\Models\Role;
use Code16\Sharp\Utils\Fields\FieldsContainer;
use Code16\Sharp\Form\Fields\SharpFormTextField;
use Code16\Sharp\Form\Layout\FormLayout;
use Code16\Sharp\Form\Layout\FormLayoutColumn;
use Code16\Sharp\Form\SharpForm;

class RoleForm extends SharpForm
{
    public function buildFormFields(FieldsContainer $formFields): void
    {
        $formFields
            ->addField(
                SharpFormTextField::make('name')
                    ->setLabel('Name')
            );
    }

    public function buildFormLayout(FormLayout $formLayout): void
    {
        $formLayout
            ->addColumn(12, function (FormLayoutColumn $column) {
                $column->withSingleField('name');
            });
    }

    public function find(mixed $id): array
    {
        return $this->transform(
            Role::findOrFail($id),
            function (Role $role) {
                return [
                    'name' => $role->name,
                ];
            }
        );
    }

    public function update(mixed $id, array $data): mixed
    {
        $role = $id ? Role::findOrFail($id) : new Role();
        $this->validate($data, [
            'name' => 'required|unique:roles,name,' . ($id ?? 'NULL') . ',id',
        ]);

        $role->fill($data);
        $role->guard_name = 'web'; // Default guard
        $role->save();

        return $role->id;
    }

    public function delete(mixed $id): void
    {
        $role = Role::findOrFail($id);
        if ($role->users()->count() > 0) {
            throw new \Code16\Sharp\Exceptions\Form\SharpApplicativeException('Cannot delete role with assigned users.');
        }
        $role->delete();
    }
}
