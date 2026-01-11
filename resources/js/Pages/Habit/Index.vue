<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, Link } from "@inertiajs/vue3";
import { Plus } from "lucide-vue-next";
import HabitItem from "@/Components/HabitItem.vue";

defineProps({
    habits: Array,
    dates: Array, // Passed from controller
});
</script>

<template>
    <Head title="Habits" />

    <AuthenticatedLayout>
        <template #header>
            <h2
                class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight"
            >
                My Habits
            </h2>
        </template>

        <div class="py-6 pb-24">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-6">
                <!-- Header Action -->
                <div class="flex justify-between items-center mb-6">
                    <h3
                        class="text-lg font-medium text-gray-900 dark:text-gray-100"
                    >
                        This Week
                    </h3>
                    <Link
                        :href="route('habits.create')"
                        class="inline-flex items-center px-4 py-2 bg-indigo-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-indigo-700 focus:bg-indigo-700 active:bg-indigo-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition ease-in-out duration-150 active:scale-95"
                    >
                        <Plus class="w-4 h-4 mr-2" />
                        New Habit
                    </Link>
                </div>

                <!-- Habits List -->
                <div
                    v-if="habits.length === 0"
                    class="text-center py-12 text-gray-500 dark:text-gray-400 bg-white dark:bg-gray-800 rounded-lg shadow-sm border border-dashed border-gray-300 dark:border-gray-700"
                >
                    <p class="mb-2">No habits tracked yet.</p>
                    <p class="text-sm">Start by creating your first habit!</p>
                </div>

                <div v-else>
                    <HabitItem
                        v-for="habit in habits"
                        :key="habit.id"
                        :habit="habit"
                        :dates="dates"
                    />
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
