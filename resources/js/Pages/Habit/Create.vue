<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm, Link } from "@inertiajs/vue3";
import InputError from "@/Components/InputError.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";

const props = defineProps({
    friends: {
        type: Array,
        default: () => [],
    },
});

const form = useForm({
    title: "",
    description: "",
    color: "#4F46E5", // Default Indigo
    frequency: "daily",
    shared_with: [],
});

const colors = [
    { name: "Red", value: "#EF4444" },
    { name: "Orange", value: "#F97316" },
    { name: "Amber", value: "#F59E0B" },
    { name: "Green", value: "#10B981" },
    { name: "Emerald", value: "#10B981" },
    { name: "Teal", value: "#14B8A6" },
    { name: "Cyan", value: "#06B6D4" },
    { name: "Blue", value: "#3B82F6" },
    { name: "Indigo", value: "#4F46E5" },
    { name: "Violet", value: "#8B5CF6" },
    { name: "Purple", value: "#A855F7" },
    { name: "Fuchsia", value: "#D946EF" },
    { name: "Pink", value: "#EC4899" },
    { name: "Rose", value: "#F43F5E" },
];

const submit = () => {
    form.post(route("habits.store"));
};
</script>

<template>
    <Head title="Create Habit" />

    <AuthenticatedLayout>
        <template #header>
            <h2
                class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight"
            >
                Create Habit
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div
                    class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg"
                >
                    <div class="p-6 text-gray-900 dark:text-gray-100">
                        <form @submit.prevent="submit" class="space-y-6">
                            <div>
                                <InputLabel for="title" value="Title" />
                                <TextInput
                                    id="title"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="form.title"
                                    required
                                    autofocus
                                    autocomplete="title"
                                    placeholder="e.g. Drink Water"
                                />
                                <InputError
                                    class="mt-2"
                                    :message="form.errors.title"
                                />
                            </div>

                            <div>
                                <InputLabel
                                    for="description"
                                    value="Description"
                                />
                                <textarea
                                    id="description"
                                    class="mt-1 block w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm"
                                    v-model="form.description"
                                    placeholder="Optional description..."
                                    rows="3"
                                ></textarea>
                                <InputError
                                    class="mt-2"
                                    :message="form.errors.description"
                                />
                            </div>

                            <div>
                                <InputLabel value="Color" />
                                <div class="mt-2 grid grid-cols-7 gap-2">
                                    <div
                                        v-for="color in colors"
                                        :key="color.value"
                                    >
                                        <label
                                            class="relative flex items-center justify-center cursor-pointer"
                                        >
                                            <input
                                                type="radio"
                                                v-model="form.color"
                                                :value="color.value"
                                                class="peer sr-only"
                                            />
                                            <div
                                                class="w-8 h-8 rounded-full border-2 transition-all"
                                                :style="{
                                                    backgroundColor:
                                                        color.value,
                                                    borderColor:
                                                        form.color ===
                                                        color.value
                                                            ? 'white'
                                                            : 'transparent',
                                                }"
                                                :class="{
                                                    'ring-2 ring-gray-400 dark:ring-gray-500':
                                                        form.color ===
                                                        color.value,
                                                }"
                                            ></div>
                                        </label>
                                    </div>
                                </div>
                                <InputError
                                    class="mt-2"
                                    :message="form.errors.color"
                                />
                            </div>

                            <div>
                                <InputLabel for="frequency" value="Frequency" />
                                <select
                                    id="frequency"
                                    class="mt-1 block w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-500 dark:focus:border-indigo-600 focus:ring-indigo-500 dark:focus:ring-indigo-600 rounded-md shadow-sm"
                                    v-model="form.frequency"
                                >
                                    <option value="daily">Daily</option>
                                    <option value="weekly">Weekly</option>
                                </select>
                                <InputError
                                    class="mt-2"
                                    :message="form.errors.frequency"
                                />
                            </div>

                            <div
                                v-if="props.friends && props.friends.length > 0"
                            >
                                <InputLabel
                                    value="Share with Friends (Optional)"
                                />
                                <div
                                    class="mt-2 space-y-2 max-h-48 overflow-y-auto border border-gray-200 dark:border-gray-700 rounded-md p-3"
                                >
                                    <div
                                        v-for="friend in props.friends"
                                        :key="friend.id"
                                        class="flex items-center"
                                    >
                                        <input
                                            :id="'friend-' + friend.id"
                                            type="checkbox"
                                            :value="friend.id"
                                            v-model="form.shared_with"
                                            class="rounded border-gray-300 text-indigo-600 shadow-sm focus:ring-indigo-500 dark:border-gray-700 dark:bg-gray-900 dark:focus:ring-indigo-600 dark:focus:ring-offset-gray-800"
                                        />
                                        <label
                                            :for="'friend-' + friend.id"
                                            class="ml-2 text-sm text-gray-700 dark:text-gray-300 cursor-pointer"
                                        >
                                            {{ friend.name }} (@{{
                                                friend.username
                                            }})
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="flex items-center gap-4">
                                <PrimaryButton
                                    :class="{ 'opacity-25': form.processing }"
                                    :disabled="form.processing"
                                >
                                    Create Habit
                                </PrimaryButton>

                                <Link
                                    :href="route('habits.index')"
                                    class="text-sm text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-100"
                                >
                                    Cancel
                                </Link>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
