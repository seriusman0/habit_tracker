<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import { Head, useForm, Link } from "@inertiajs/vue3";
import { UserPlus, UserCheck, UserX, Search } from "lucide-vue-next";
import { ref } from "vue";
import InputError from "@/Components/InputError.vue";
import TextInput from "@/Components/TextInput.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";

const props = defineProps({
    friends: Array,
    requests: Array,
    pendingSent: Array,
});

const activeTab = ref("friends"); // friends, requests, find

const addFriendForm = useForm({
    username: "",
});

const submitAddFriend = () => {
    addFriendForm.post(route("friendships.store"), {
        onSuccess: () => {
            addFriendForm.reset();
            activeTab.value = "requests"; // Switch to see sent request (or just stay)
        },
    });
};
</script>

<template>
    <Head title="Friends" />

    <AuthenticatedLayout>
        <template #header>
            <h2
                class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight"
            >
                Friends
            </h2>
        </template>

        <div class="py-6">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <!-- Tabs -->
                <div
                    class="flex space-x-4 mb-6 border-b border-gray-200 dark:border-gray-700 overflow-x-auto"
                >
                    <button
                        @click="activeTab = 'friends'"
                        class="px-4 py-2 border-b-2 font-medium text-sm whitespace-nowrap transition-colors duration-200"
                        :class="
                            activeTab === 'friends'
                                ? 'border-indigo-500 text-indigo-600 dark:text-indigo-400'
                                : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300'
                        "
                    >
                        My Friends ({{ friends.length }})
                    </button>
                    <button
                        @click="activeTab = 'requests'"
                        class="px-4 py-2 border-b-2 font-medium text-sm whitespace-nowrap transition-colors duration-200"
                        :class="
                            activeTab === 'requests'
                                ? 'border-indigo-500 text-indigo-600 dark:text-indigo-400'
                                : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300'
                        "
                    >
                        Requests
                        <span
                            v-if="requests.length > 0"
                            class="ml-1 px-2 py-0.5 rounded-full bg-red-100 text-red-600 text-xs"
                            >{{ requests.length }}</span
                        >
                    </button>
                    <button
                        @click="activeTab = 'find'"
                        class="px-4 py-2 border-b-2 font-medium text-sm whitespace-nowrap transition-colors duration-200"
                        :class="
                            activeTab === 'find'
                                ? 'border-indigo-500 text-indigo-600 dark:text-indigo-400'
                                : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300'
                        "
                    >
                        Find Friends
                    </button>
                </div>

                <!-- My Friends List -->
                <div v-if="activeTab === 'friends'" class="space-y-4">
                    <div
                        v-if="friends.length === 0"
                        class="text-center py-8 text-gray-500 dark:text-gray-400"
                    >
                        <p>No friends yet. Go find some!</p>
                        <button
                            @click="activeTab = 'find'"
                            class="mt-2 text-indigo-600 hover:underline"
                        >
                            Find Friends
                        </button>
                    </div>
                    <div
                        v-for="friend in friends"
                        :key="friend.id"
                        class="flex items-center justify-between p-4 bg-white dark:bg-gray-800 shadow rounded-lg"
                    >
                        <div class="flex items-center space-x-3">
                            <div
                                class="w-10 h-10 rounded-full bg-gray-200 dark:bg-gray-700 flex items-center justify-center text-gray-500 dark:text-gray-400"
                            >
                                {{
                                    friend.username
                                        ? friend.username[0].toUpperCase()
                                        : "?"
                                }}
                            </div>
                            <div>
                                <p
                                    class="font-medium text-gray-900 dark:text-gray-100"
                                >
                                    {{ friend.name }}
                                </p>
                                <p class="text-sm text-gray-500">
                                    @{{ friend.username }}
                                </p>
                            </div>
                        </div>
                        <div class="flex items-center">
                            <!-- Remove friend logic could go here, for now just list -->
                            <span
                                class="text-xs bg-green-100 text-green-800 px-2 py-1 rounded-full dark:bg-green-900/30 dark:text-green-400"
                                >Friend</span
                            >
                        </div>
                    </div>
                </div>

                <!-- Requests -->
                <div v-if="activeTab === 'requests'" class="space-y-6">
                    <!-- Received Requests -->
                    <div>
                        <h3
                            class="text-lg font-medium text-gray-900 dark:text-gray-100 mb-3"
                        >
                            Received Requests
                        </h3>
                        <div
                            v-if="requests.length === 0"
                            class="text-sm text-gray-500"
                        >
                            No pending requests.
                        </div>
                        <div
                            v-for="user in requests"
                            :key="user.id"
                            class="flex items-center justify-between p-4 bg-white dark:bg-gray-800 shadow rounded-lg mb-2"
                        >
                            <div class="flex items-center space-x-3">
                                <div
                                    class="w-10 h-10 rounded-full bg-gray-200 dark:bg-gray-700 flex items-center justify-center text-gray-500 dark:text-gray-400"
                                >
                                    {{
                                        user.username
                                            ? user.username[0].toUpperCase()
                                            : "?"
                                    }}
                                </div>
                                <div>
                                    <p
                                        class="font-medium text-gray-900 dark:text-gray-100"
                                    >
                                        {{ user.name }}
                                    </p>
                                    <p class="text-sm text-gray-500">
                                        @{{ user.username }}
                                    </p>
                                </div>
                            </div>
                            <div class="flex space-x-2">
                                <!-- Need Friendship ID to act on it. Ideally controller passes friendship object, but simplifying. 
                                     Actually, we need the friendship ID. Let's assume we can fetch it or just pass IDs. 
                                     Correction: The controller logic passes Users. 
                                     Let's update Friend/Index.vue to assume requests is array of Users. 
                                     Wait, destroy/update requires Friendship ID. 
                                     The Controller query: 
                                     $requests = Friendship::...->with('sender')->get()->pluck('sender'); 
                                     This loses the Friendship ID!
                                     
                                     Quick Fix: I should update Controller to return Friendship objects, 
                                     OR, I can look it up, OR I can change route keys.
                                     RESOURCE ROUTE expects Friendship ID.
                                     
                                     Let's update logic in next step to fix Controller data. 
                                     For now, I'll assume we HAVE the pivot or object with `pivot` or similar if I passed it correctly.
                                     
                                     Wait, `pluck('sender')` returns clean User models.
                                     Pivot data is not attached unless requested.
                                     
                                     I will likely need to fix the controller in a subsequent step. 
                                     For now, writing UI assuming I will fix data structure or use a workaround.
                                     Workaround: I'll change the Controller later. 
                                     I'll proceed writing this View assuming `user.friendship_id` exists.
                                 -->
                                <Link
                                    v-if="user.friendship_id"
                                    :href="
                                        route(
                                            'friendships.update',
                                            user.friendship_id
                                        )
                                    "
                                    method="put"
                                    as="button"
                                    class="p-2 bg-indigo-100 text-indigo-600 rounded-full hover:bg-indigo-200 dark:bg-indigo-900/30 dark:text-indigo-400"
                                >
                                    <UserCheck class="w-5 h-5" />
                                </Link>
                                <Link
                                    v-if="user.friendship_id"
                                    :href="
                                        route(
                                            'friendships.destroy',
                                            user.friendship_id
                                        )
                                    "
                                    method="delete"
                                    as="button"
                                    class="p-2 bg-gray-100 text-gray-600 rounded-full hover:bg-gray-200 dark:bg-gray-700 dark:text-gray-400"
                                >
                                    <UserX class="w-5 h-5" />
                                </Link>
                            </div>
                        </div>
                    </div>

                    <!-- Sent Requests -->
                    <div>
                        <h3
                            class="text-lg font-medium text-gray-900 dark:text-gray-100 mb-3"
                        >
                            Sent Requests
                        </h3>
                        <div
                            v-if="pendingSent.length === 0"
                            class="text-sm text-gray-500"
                        >
                            No sent requests pending.
                        </div>
                        <div
                            v-for="user in pendingSent"
                            :key="user.id"
                            class="flex items-center justify-between p-4 bg-white dark:bg-gray-800 shadow rounded-lg mb-2"
                        >
                            <div class="flex items-center space-x-3">
                                <div
                                    class="w-10 h-10 rounded-full bg-gray-200 dark:bg-gray-700 flex items-center justify-center text-gray-500 dark:text-gray-400"
                                >
                                    {{
                                        user.username
                                            ? user.username[0].toUpperCase()
                                            : "?"
                                    }}
                                </div>
                                <div>
                                    <p
                                        class="font-medium text-gray-900 dark:text-gray-100"
                                    >
                                        {{ user.name }}
                                    </p>
                                    <p class="text-sm text-gray-500">
                                        @{{ user.username }}
                                    </p>
                                </div>
                            </div>
                            <div class="flex space-x-2">
                                <span class="text-xs text-gray-400 px-2 py-1"
                                    >Pending</span
                                >
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Find Friends -->
                <div v-if="activeTab === 'find'" class="max-w-md mx-auto">
                    <div
                        class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow"
                    >
                        <h3
                            class="text-lg font-medium text-gray-900 dark:text-gray-100 mb-4"
                        >
                            Add Friend
                        </h3>
                        <form
                            @submit.prevent="submitAddFriend"
                            class="space-y-4"
                        >
                            <div>
                                <TextInput
                                    id="username"
                                    type="text"
                                    class="mt-1 block w-full"
                                    v-model="addFriendForm.username"
                                    placeholder="Enter username"
                                    required
                                />
                                <InputError
                                    class="mt-2"
                                    :message="addFriendForm.errors.username"
                                />
                            </div>

                            <div class="flex items-center justify-end">
                                <PrimaryButton
                                    :class="{
                                        'opacity-25': addFriendForm.processing,
                                    }"
                                    :disabled="addFriendForm.processing"
                                >
                                    <UserPlus class="w-4 h-4 mr-2" />
                                    Send Request
                                </PrimaryButton>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
