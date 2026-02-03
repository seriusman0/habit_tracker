<x-filament::widget>
    <x-filament::section>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-5">
            <!-- My Classes Summary -->
            <a href="/mentor/my-classes"
                class="block p-6 bg-gray-50 border border-gray-200 rounded-lg text-center transition hover:bg-gray-100 dark:bg-white/5 dark:border-white/10 dark:hover:bg-white/10">
                <h3 class="text-xl font-semibold mb-2 text-gray-900 dark:text-white">My Classes</h3>
                <p class="text-base text-gray-600 dark:text-gray-400">{{ $classCount }} Classes</p>
            </a>

            <!-- My Students Summary -->
            <a href="/mentor/my-students"
                class="block p-6 bg-gray-50 border border-gray-200 rounded-lg text-center transition hover:bg-gray-100 dark:bg-white/5 dark:border-white/10 dark:hover:bg-white/10">
                <h3 class="text-xl font-semibold mb-2 text-gray-900 dark:text-white">My Students</h3>
                <p class="text-base text-gray-600 dark:text-gray-400">{{ $studentCount }} Students</p>
            </a>

            <!-- Assigned Habits Summary -->
            <div class="block p-6 bg-gray-50 border border-gray-200 rounded-lg text-center dark:bg-white/5 dark:border-white/10">
                <h3 class="text-xl font-semibold mb-2 text-gray-900 dark:text-white">Assigned Habits</h3>
                <p class="text-base text-gray-600 dark:text-gray-400">{{ $assignedHabitsCount }} Assignments</p>
            </div>
        </div>
    </x-filament::section>
</x-filament::widget>