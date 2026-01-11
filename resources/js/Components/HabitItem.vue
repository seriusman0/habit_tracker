<script setup>
import { Link, router } from "@inertiajs/vue3";
import { Check, X } from "lucide-vue-next";

const props = defineProps({
    habit: Object,
    dates: Array, // Array of date objects { date, day, is_today }
});

const toggleStatus = (date) => {
    router.post(
        route("habits.toggle", { habit: props.habit.id, date: date }),
        {},
        {
            preserveScroll: true,
        }
    );
};

const getStatusColor = (status) => {
    if (status === "completed")
        return "bg-green-100 text-green-600 border-green-200 dark:bg-green-900/30 dark:text-green-400 dark:border-green-800";
    if (status === "skipped")
        return "bg-red-100 text-red-600 border-red-200 dark:bg-red-900/30 dark:text-red-400 dark:border-red-800";
    return "bg-gray-100 text-gray-400 border-gray-200 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-500 dark:border-gray-700 dark:hover:bg-gray-700";
};
</script>

<template>
    <div
        class="p-4 bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-100 dark:border-gray-700 mb-4"
    >
        <!-- Header -->
        <div class="flex justify-between items-start mb-4">
            <div>
                <h3
                    class="font-bold text-lg text-indigo-900 dark:text-indigo-100"
                >
                    {{ habit.title }}
                </h3>
                <div
                    class="flex items-center space-x-2 text-xs text-gray-500 dark:text-gray-400 mt-1"
                >
                    <span>{{
                        habit.frequency === "daily" ? "Daily" : "Weekly"
                    }}</span>
                    <span>&bull;</span>
                    <!-- Placeholder Stats -->
                    <span>Streak: {{ habit.streak || 0 }}</span>
                </div>
            </div>
            <Link
                :href="route('habits.edit', habit.id)"
                class="text-gray-400 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors"
            >
                <span class="sr-only">Edit</span>
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="16"
                    height="16"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                >
                    <path d="M12 20h9" />
                    <path d="M16.5 3.5a2.12 2.12 0 0 1 3 3L7 19l-4 1 1-4Z" />
                </svg>
            </Link>
        </div>

        <!-- Weekly Row -->
        <div class="flex justify-between items-center">
            <div
                v-for="dayObj in dates"
                :key="dayObj.date"
                class="flex flex-col items-center space-y-2"
            >
                <!-- Circle Button -->
                <button
                    @click="toggleStatus(dayObj.date)"
                    class="w-10 h-10 rounded-full flex items-center justify-center border transition-all duration-200 active:scale-90"
                    :class="getStatusColor(habit.logs_keyed[dayObj.date])"
                >
                    <Check
                        v-if="habit.logs_keyed[dayObj.date] === 'completed'"
                        class="w-5 h-5"
                    />
                    <X
                        v-else-if="habit.logs_keyed[dayObj.date] === 'skipped'"
                        class="w-5 h-5"
                    />
                    <span
                        v-else
                        class="text-[10px] font-medium opacity-0 group-hover:opacity-50"
                    ></span>
                </button>

                <!-- Day Label -->
                <div class="text-center">
                    <span
                        class="block text-[10px] font-medium text-gray-400 dark:text-gray-500 uppercase tracking-wider"
                    >
                        {{ dayObj.day }}
                    </span>
                    <span
                        v-if="dayObj.is_today"
                        class="block text-[9px] font-bold text-indigo-600 dark:text-indigo-400 mt-0.5"
                    >
                        TODAY
                    </span>
                </div>
            </div>
        </div>
    </div>
</template>
