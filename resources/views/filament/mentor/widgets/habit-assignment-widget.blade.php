<x-filament::widget>
    <x-filament::section>
        <div x-data="{
            dragging: null,
            handleDragStart(event, habitId) {
                this.dragging = habitId;
                event.dataTransfer.effectAllowed = 'copy';
                event.dataTransfer.setData('text/plain', habitId);
                event.target.classList.add('opacity-50');
            },
            handleDragEnd(event) {
                this.dragging = null;
                event.target.classList.remove('opacity-50');
            },
            handleDrop(event) {
                const habitId = event.dataTransfer.getData('text/plain');
                if (habitId) {
                    $wire.assignHabit(habitId);
                }
            }
        }">
            <h2 class="text-lg font-bold mb-4">Assign Habits</h2>

            <div class="mb-4">
                <label for="student" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Select Student</label>
                <select id="student" wire:model.live="selectedStudentId" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 dark:bg-gray-800 dark:border-gray-600 dark:text-white sm:text-sm">
                    <option value="">-- Select a Student --</option>
                    @foreach($students as $student)
                    <option value="{{ $student['id'] }}">{{ $student['name'] }} ({{ $student['email'] }})</option>
                    @endforeach
                </select>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6" @if(!$selectedStudentId) style="opacity: 0.5; pointer-events: none;" @endif>

                <!-- Templates Column -->
                <div class="bg-gray-50 dark:bg-gray-900 p-4 rounded-lg">
                    <h3 class="font-semibold mb-3 text-gray-700 dark:text-gray-200">Available Templates</h3>
                    <div class="space-y-4">
                        @foreach($categories as $category)
                        <div>
                            <h4 class="text-sm font-medium text-gray-500 dark:text-gray-400 mb-2 uppercase">{{ $category['name'] }}</h4>
                            <div class="space-y-2">
                                @foreach($category['habits'] as $habit)
                                <div
                                    draggable="true"
                                    @dragstart="handleDragStart($event, {{ $habit['id'] }})"
                                    @dragend="handleDragEnd($event)"
                                    class="bg-white dark:bg-gray-800 p-3 rounded shadow cursor-move hover:bg-gray-100 dark:hover:bg-gray-700 border-l-4"
                                    style="border-color: {{ $habit['color'] }};">
                                    <div class="font-medium">{{ $habit['title'] }}</div>
                                    <div class="text-xs text-gray-500">{{ ucfirst($habit['frequency']) }}</div>
                                </div>
                                @endforeach
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>

                <!-- Assigned Column -->
                <div
                    @dragover.prevent="$event.dataTransfer.dropEffect = 'copy'"
                    @drop.prevent="handleDrop($event)"
                    class="bg-gray-50 dark:bg-gray-900 p-4 rounded-lg min-h-[300px] border-2 border-dashed border-gray-300 dark:border-gray-700">
                    <h3 class="font-semibold mb-3 text-gray-700 dark:text-gray-200">Assigned Habits</h3>

                    @if(empty($selectedStudentHabits))
                    <div class="text-center text-gray-400 py-10">
                        Drag templates here to assign
                    </div>
                    @else
                    <div class="space-y-2">
                        @foreach($selectedStudentHabits as $habit)
                        <div class="bg-white dark:bg-gray-800 p-3 rounded shadow flex justify-between items-center border-l-4"
                            style="border-color: {{ $habit['color'] }};">
                            <div>
                                <div class="font-medium">{{ $habit['title'] }}</div>
                                <div class="text-xs text-gray-500">{{ ucfirst($habit['frequency']) }}</div>
                            </div>
                            <button
                                wire:click="removeHabit({{ $habit['id'] }})"
                                wire:loading.attr="disabled"
                                class="text-red-500 hover:text-red-700 p-1 rounded hover:bg-red-50 dark:hover:bg-red-900/20"
                                title="Remove assignment">
                                <x-heroicon-o-trash class="w-5 h-5" />
                            </button>
                        </div>
                        @endforeach
                    </div>
                    @endif
                </div>

            </div>
        </div>
    </x-filament::section>
</x-filament::widget>