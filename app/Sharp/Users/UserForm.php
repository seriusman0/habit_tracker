<?php

namespace App\Sharp\Users;

use App\Models\User;
use Code16\Sharp\Utils\Fields\FieldsContainer;
use Code16\Sharp\Form\Fields\SharpFormSelectField;
use Code16\Sharp\Form\Fields\SharpFormTextField;
use Code16\Sharp\Form\Layout\FormLayout;
use Code16\Sharp\Form\Layout\FormLayoutColumn;
use Code16\Sharp\Form\SharpForm;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class UserForm extends SharpForm
{
    public function buildFormFields(FieldsContainer $formFields): void
    {
        $formFields
            ->addField(
                SharpFormTextField::make('name')
                    ->setLabel('Name')
            )
            ->addField(
                SharpFormTextField::make('email')
                    ->setLabel('Email')
            )
            ->addField(
                SharpFormTextField::make('password')
                    ->setLabel('Password')
                    ->setInputType('password')
            )
            ->addField(
                SharpFormSelectField::make(
                    'roles',
                    Role::orderBy('name')->pluck('name', 'id')->toArray()
                )
                    ->setLabel('Roles')
                    ->setMultiple()
            )
            ->addField(
                SharpFormSelectField::make(
                    'guardians',
                    User::whereHas('roles', function ($query) {
                        $query->where('name', 'parent');
                    })->orderBy('name')->pluck('name', 'id')->toArray()
                )
                    ->setLabel('Guardians (for Students)')
                    ->setMultiple()
            );
    }

    public function buildFormLayout(FormLayout $formLayout): void
    {
        $formLayout
            ->addColumn(6, function (FormLayoutColumn $column) {
                $column->withSingleField('name')
                    ->withSingleField('email')
                    ->withSingleField('password');
            })
            ->addColumn(6, function (FormLayoutColumn $column) {
                $column->withSingleField('roles')
                    ->withSingleField('guardians');
            });
    }

    public function find(mixed $id): array
    {
        return $this->transform(
            User::with(['roles', 'guardians'])->findOrFail($id),
            function (User $user) {
                return [
                    'name' => $user->name,
                    'email' => $user->email,
                    'roles' => $user->roles->pluck('id')->toArray(),
                    'guardians' => $user->guardians->pluck('id')->toArray(),
                ];
            }
        );
    }

    public function update(mixed $id, array $data): mixed
    {
        $user = $id ? User::findOrFail($id) : new User();

        $this->save($user, $data);

        return $user->id;
    }

    public function delete(mixed $id): void
    {
        User::findOrFail($id)->delete();
    }

    private function save(User $user, array $data): void
    {
        $user->fill($data);
        if (isset($data['password'])) {
            $user->password = Hash::make($data['password']);
        }
        $user->save();

        if (isset($data['roles'])) {
            $user->syncRoles($data['roles']);
        }

        if (isset($data['guardians'])) {
            $user->guardians()->sync($data['guardians']);
        }
    }
}
