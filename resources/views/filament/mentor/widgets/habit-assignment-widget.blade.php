<x-filament::widget>
    <x-filament::section>
        <div>
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
                        <div wire:key="category-{{ $category['id'] }}">
                            <h4 class="text-sm font-medium text-gray-500 dark:text-gray-400 mb-2 uppercase">{{ $category['name'] }}</h4>
                            <div class="space-y-2">
                                @foreach($category['habits'] as $habit)
                                <div
                                    wire:key="template-{{ $habit['id'] }}"
                                    class="bg-white dark:bg-gray-800 p-3 rounded shadow flex justify-between items-center border-l-4 transition-colors hover:bg-gray-100 dark:hover:bg-gray-700"
                                    @style(['border-color: ' . ($habit[' color'] ?? '#ccc' )])>
                                    <div>
                                        <div class="font-medium">{{ $habit['title'] }}</div>
                                        <div class="text-xs text-gray-500">{{ ucfirst($habit['frequency']) }}</div>
                                    </div>
                                    <button
                                        wire:click="assignHabit({{ $habit['id'] }})"
                                        wire:loading.attr="disabled"
                                        class="text-indigo-600 hover:text-indigo-800 dark:text-indigo-400 dark:hover:text-indigo-300 text-sm font-medium px-2 py-1 rounded hover:bg-indigo-50 dark:hover:bg-indigo-900/20 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">

                                        <span wire:loading.remove wire:target="assignHabit({{ $habit['id'] }})">
                                            Assign
                                        </span>
                                        <span wire:loading wire:target="assignHabit({{ $habit['id'] }})">
                                            ...
                                        </span>
                                    </button>
                                </div>
                                @endforeach
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>

                <!-- Assigned Column -->
                <div class="bg-gray-50 dark:bg-gray-900 p-4 rounded-lg min-h-[300px]">
                    <h3 class="font-semibold mb-3 text-gray-700 dark:text-gray-200">Assigned Habits</h3>

                    @if(empty($selectedStudentHabits))
                    <div class="text-center text-gray-400 py-10">
                        Select a student to view assigned habits.
                    </div>
                    @else
                    <div class="space-y-2">
                        @foreach($selectedStudentHabits as $habit)
                        <div
                            wire:key="assigned-{{ $habit['id'] }}"
                            class="bg-white dark:bg-gray-800 p-3 rounded shadow flex justify-between items-center border-l-4"
                            @style(['border-color: ' . ($habit[' color'] ?? '#ccc' )])>
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