<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head } from "@inertiajs/vue3";
import { Check } from "lucide-vue-next";

defineProps({
    habits: Array,
});
</script>

<template>
    <Head title="Social Feed" />

    <AuthenticatedLayout>
        <template #header>
            <h2
                class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight"
            >
                Social Feed
            </h2>
        </template>

        <div class="py-6 pb-24">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-4">
                <div
                    v-if="habits.length === 0"
                    class="text-center py-10 text-gray-500 dark:text-gray-400"
                >
                    <p>No activity yet.</p>
                    <p class="text-sm">
                        Your friends haven't shared any habits with you
                        recently.
                    </p>
                </div>

                <div
                    v-for="habit in habits"
                    :key="habit.id"
                    class="p-4 bg-white dark:bg-gray-800 overflow-hidden shadow-sm rounded-lg"
                    :style="{ borderLeft: `5px solid ${habit.color}` }"
                >
                    <div class="flex items-center justify-between mb-2">
                        <div class="flex items-center space-x-2">
                            <div
                                class="w-8 h-8 rounded-full bg-gray-200 dark:bg-gray-700 flex items-center justify-center text-xs text-gray-500 dark:text-gray-400 font-bold"
                            >
                                {{
                                    habit.user.username
                                        ? habit.user.username[0].toUpperCase()
                                        : "?"
                                }}
                            </div>
                            <div>
                                <span
                                    class="text-sm font-medium text-gray-900 dark:text-gray-100"
                                    >@{{ habit.user.username }}</span
                                >
                                <span class="text-xs text-gray-500 block"
                                    >Shared Habit</span
                                >
                            </div>
                        </div>
                    </div>

                    <div class="flex items-center justify-between">
                        <div>
                            <h3
                                class="text-lg font-medium text-gray-900 dark:text-gray-100"
                            >
                                {{ habit.title }}
                            </h3>
                            <p
                                v-if="habit.description"
                                class="text-sm text-gray-500 dark:text-gray-400 line-clamp-1"
                            >
                                {{ habit.description }}
                            </p>
                        </div>

                        <div
                            v-if="habit.today_log"
                            class="flex items-center text-green-600 dark:text-green-400"
                        >
                            <Check class="w-5 h-5 mr-1" />
                            <span class="text-sm font-medium">Done Today</span>
                        </div>
                        <div
                            v-else
                            class="text-sm text-gray-400 dark:text-gray-500 italic"
                        >
                            Not done yet
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
