<x-filament-widgets::widget class="w-full col-span-full">
    <div class="bg-white px-4 py-4 md:px-6 md:py-6 rounded-xl shadow-sm border border-gray-200 w-full h-full">
        <!-- Main Container: Stack on small screens, Row on medium+ -->
        <div class="flex flex-col md:flex-row gap-6 w-full h-full min-h-[600px]"
            x-data="{
                draggedHabitId: null,
                handleDragStart(event, habitId) {
                    this.draggedHabitId = habitId;
                    event.dataTransfer.effectAllowed = 'copy';
                    event.dataTransfer.setData('text/plain', habitId);
                    event.target.classList.add('opacity-50');
                },
                handleDragEnd(event) {
                    this.draggedHabitId = null;
                    event.target.classList.remove('opacity-50');
                },
                handleDrop(event, studentId) {
                    const habitId = event.dataTransfer.getData('text/plain');
                    if (habitId) {
                        $wire.assignHabit(habitId, studentId);
                    }
                    event.currentTarget.classList.remove('bg-gray-100', 'border-primary-500');
                },
                handleDragOver(event) {
                    event.preventDefault(); // Necessary to allow dropping
                    event.dataTransfer.dropEffect = 'copy';
                    event.currentTarget.classList.add('bg-gray-100', 'border-primary-500');
                },
                handleDragLeave(event) {
                    event.currentTarget.classList.remove('bg-gray-100', 'border-primary-500');
                }
             }">

            <!-- Left Column: Available Habits (Templates) -->
            <div class="flex-1 min-w-0 bg-gray-50 rounded-lg p-4 border border-gray-200 flex flex-col h-[500px] md:h-auto">
                <h3 class="text-lg font-bold mb-4 text-gray-700 flex items-center gap-2 shrink-0">
                    <x-heroicon-o-book-open class="w-5 h-5" />
                    Templates
                </h3>

                <div class="space-y-4 overflow-y-auto flex-1 pr-2">
                    @foreach($categories as $category)
                    @if(count($category['habits']) > 0)
                    <div class="category-group">
                        <h4 class="text-xs font-bold text-gray-500 uppercase tracking-wider mb-2">
                            {{ $category['name'] }}
                        </h4>
                        <div class="grid grid-cols-1 gap-2">
                            @foreach($category['habits'] as $habit)
                            <div draggable="true"
                                @dragstart="handleDragStart($event, {{ $habit['id'] }})"
                                @dragend="handleDragEnd($event)"
                                class="bg-white p-2 rounded-md shadow-sm border border-gray-200 cursor-move hover:shadow-md hover:border-primary-400 transition-all group">
                                <div class="flex items-center gap-2">
                                    <div class="w-2 h-2 rounded-full shrink-0" style="background-color: {{ $habit['color'] }}"></div>
                                    <div class="flex-1 min-w-0">
                                        <div class="text-sm font-medium text-gray-800 truncate">{{ $habit['title'] }}</div>
                                        <div class="text-[10px] text-gray-500 capitalize">{{ $habit['frequency'] }}</div>
                                    </div>
                                    <x-heroicon-o-bars-2 class="w-4 h-4 text-gray-400 opacity-0 group-hover:opacity-100 shrink-0" />
                                </div>
                            </div>
                            @endforeach
                        </div>
                    </div>
                    @endif
                    @endforeach

                    @if(empty($categories))
                    <div class="text-center py-8 text-gray-400 text-sm">
                        No templates found.
                    </div>
                    @endif
                </div>
            </div>

            <!-- Middle Column: Students -->
            <div class="flex-1 min-w-0 bg-gray-50 rounded-lg p-4 border border-gray-200 flex flex-col h-[500px] md:h-auto">
                <h3 class="text-lg font-bold mb-4 text-gray-700 flex items-center gap-2 shrink-0">
                    <x-heroicon-o-users class="w-5 h-5" />
                    Students
                </h3>

                <div class="space-y-3 overflow-y-auto flex-1 pr-2">
                    @foreach($students as $student)
                    <div class="student-card bg-white rounded-lg shadow-sm border-2 border-transparent transition-all cursor-pointer hover:border-gray-300 relative"
                        :class="{ 'border-primary-500 ring-2 ring-primary-100 ring-opacity-50': $wire.selectedStudentId === {{ $student['id'] }} }"
                        wire:click="selectStudent({{ $student['id'] }})"
                        @dragover="handleDragOver($event)"
                        @dragleave="handleDragLeave($event)"
                        @drop="handleDrop($event, {{ $student['id'] }})">

                        <div class="p-3 flex items-center justify-between pointer-events-none">
                            <div class="flex items-center gap-3">
                                @if($student['avatar'])
                                <img src="{{ $student['avatar'] }}" class="w-8 h-8 rounded-full bg-gray-200 object-cover" alt="{{ $student['name'] }}">
                                @else
                                <div class="w-8 h-8 rounded-full bg-primary-100 text-primary-600 flex items-center justify-center font-bold text-sm">
                                    {{ substr($student['name'], 0, 1) }}
                                </div>
                                @endif
                                <div class="min-w-0">
                                    <div class="font-semibold text-gray-800 text-sm truncate max-w-[120px]">{{ $student['name'] }}</div>
                                    <div class="text-[10px] text-gray-500 truncate">{{ $student['email'] }}</div>
                                </div>
                            </div>
                            <div class="flex flex-col items-end gap-1">
                                <span class="text-[10px] font-medium bg-gray-100 text-gray-600 px-2 py-0.5 rounded-full">
                                    {{ $student['habits_count'] }}
                                </span>
                            </div>
                        </div>

                        <div class="absolute inset-0 flex items-center justify-center bg-primary-50 bg-opacity-90 rounded-lg opacity-0 drag-hint transition-opacity pointer-events-none border-2 border-primary-500 border-dashed">
                            <span class="text-primary-700 font-bold text-sm">Drop to Assign</span>
                        </div>
                    </div>
                    @endforeach

                    @if(empty($students))
                    <div class="text-center py-8 text-gray-400 text-sm">
                        No students found.
                    </div>
                    @endif
                </div>
            </div>

            <!-- Right Column: Selected Student Details -->
            <div class="flex-1 min-w-0 bg-white rounded-lg border border-gray-200 shadow-sm flex flex-col h-[500px] md:h-auto overflow-hidden">
                @if($selectedStudentId)
                <div class="p-4 bg-gray-50 border-b border-gray-200 shrink-0">
                    <h3 class="text-lg font-bold text-gray-800">
                        Assigned Habits
                    </h3>
                    <p class="text-sm text-gray-500">
                        Managing habits for <span class="font-medium text-gray-900">{{ collect($students)->firstWhere('id', $selectedStudentId)['name'] ?? 'Student' }}</span>
                    </p>
                </div>

                <div class="p-4 overflow-y-auto flex-1 relative">
                    <!-- Loading State -->
                    <div wire:loading.flex wire:target="selectStudent" class="absolute inset-0 bg-white/80 z-10 flex items-center justify-center">
                        <x-filament::loading-indicator class="w-8 h-8 text-primary-500" />
                    </div>

                    @if(count($selectedStudentHabits) > 0)
                    <div class="grid gap-3">
                        @foreach($selectedStudentHabits as $habit)
                        <div class="flex items-center justify-between p-3 bg-white border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition-shadow group">
                            <div class="flex items-center gap-3">
                                <div class="w-10 h-10 rounded-full flex items-center justify-center shrink-0" style="background-color: {{ $habit['color'] }}20; color: {{ $habit['color'] }}">
                                    <span class="font-bold text-lg">{{ substr($habit['title'], 0, 1) }}</span>
                                </div>
                                <div>
                                    <h4 class="font-bold text-gray-800">{{ $habit['title'] }}</h4>
                                    <div class="flex items-center gap-2 mt-0.5">
                                        <span class="text-xs text-gray-500 bg-gray-100 px-1.5 py-0.5 rounded capitalize">
                                            {{ $habit['frequency'] }}
                                        </span>
                                        <span class="text-[10px] text-gray-400 flex items-center gap-1">
                                            <div class="w-1.5 h-1.5 rounded-full" style="background-color: {{ $habit['color'] }}"></div>
                                            {{ $habit['category_name'] }}
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <button
                                wire:click="deleteHabit({{ $habit['id'] }})"
                                wire:confirm="Are you sure you want to delete this habit?"
                                class="text-gray-400 hover:text-red-500 p-1.5 rounded-full hover:bg-red-50 transition-colors"
                                title="Delete Habit">
                                <x-heroicon-o-trash class="w-5 h-5" />
                            </button>
                        </div>
                        @endforeach
                    </div>
                    @else
                    <div class="h-full flex flex-col items-center justify-center text-center text-gray-400 p-8 opacity-60">
                        <x-heroicon-o-clipboard-document-list class="w-12 h-12 mb-3 text-gray-300" />
                        <p>No habits assigned to this student yet.</p>
                        <p class="text-xs mt-1">Drag templates from the left template list to assign one.</p>
                    </div>
                    @endif
                </div>
                @else
                <div class="h-full flex flex-col items-center justify-center text-center text-gray-400 p-8">
                    <div class="bg-gray-50 p-4 rounded-full mb-4">
                        <x-heroicon-o-cursor-arrow-rays class="w-8 h-8 text-gray-400" />
                    </div>
                    <h4 class="font-medium text-gray-600 text-lg mb-1">No Student Selected</h4>
                    <p class="text-sm">Click on a student to view their assigned habits.</p>
                </div>
                @endif
            </div>
        </div>
    </div>

    <style>
        .student-card.border-primary-500 .drag-hint {
            opacity: 1;
        }
    </style>
</x-filament-widgets::widget>