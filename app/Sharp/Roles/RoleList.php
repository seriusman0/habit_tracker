namespace App\Sharp\Roles;

use Spatie\Permission\Models\Role;
use Code16\Sharp\EntityList\SharpEntityList;
use Code16\Sharp\EntityList\Fields\EntityListFieldsContainer;
use Code16\Sharp\EntityList\Fields\EntityListField;
use Illuminate\Contracts\Support\Arrayable;

class RoleList extends SharpEntityList
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
EntityListField::make('guard_name')
->setLabel('Guard Name')
)
->addField(
EntityListField::make('users_count')
->setLabel('Users Count')
);
}

public function buildListConfig(): void
{
$this
->setSearchable(['name'])
->setDefaultSort('name', 'asc')
->setPaginated(30);
}

public function getListData(): array|Arrayable
{
$roles = Role::query()
->withCount('users')
->select('id', 'name', 'guard_name');

return $this->transform(
$roles->paginate(30),
fn (Role $role) => [
'id' => $role->id,
'name' => $role->name,
'guard_name' => $role->guard_name,
'users_count' => $role->users_count,
]
);
}
}