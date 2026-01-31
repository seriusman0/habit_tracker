<script setup>
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ListTodo, Users, Home, User, LogOut, Search } from "lucide-vue-next";
import { ref, computed } from "vue";

const props = defineProps({
    friends: Array,
});

const search = ref("");

const filteredFriends = computed(() => {
    if (!search.value) return props.friends;
    return props.friends.filter(
        (friend) =>
            friend.name.toLowerCase().includes(search.value.toLowerCase()) ||
            friend.email.toLowerCase().includes(search.value.toLowerCase()),
    );
});

const logout = () => {
    useForm({}).post(route("logout"));
};
</script>

<template>
    <Head title="Teman Kelas" />

    <div
        class="bg-gray-200 dark:bg-gray-900 font-sans min-h-screen flex items-center justify-center p-4 selection:bg-indigo-500 selection:text-white"
    >
        <div
            class="w-full max-w-md bg-white dark:bg-gray-800 h-[850px] rounded-[30px] shadow-2xl overflow-hidden flex flex-col relative border border-gray-300 dark:border-gray-700"
        >
            <!-- Header -->
            <header
                class="bg-white dark:bg-gray-700 px-6 py-5 border-b border-gray-200 dark:border-gray-600 sticky top-0 z-20 flex justify-between items-center"
            >
                <h1 class="text-2xl font-bold text-gray-900 dark:text-gray-100">
                    Teman Kelas
                </h1>
                <button
                    @click="logout"
                    class="text-gray-500 hover:text-red-500 transition-colors"
                >
                    <LogOut class="w-6 h-6" />
                </button>
            </header>

            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto px-6 py-6 scrollbar-hide">
                <div class="relative mb-6">
                    <input
                        v-model="search"
                        type="text"
                        placeholder="Cari teman..."
                        class="w-full pl-10 pr-4 py-2 rounded-lg border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-indigo-500 focus:border-indigo-500 transition-colors"
                    />
                    <Search
                        class="absolute left-3 top-2.5 w-5 h-5 text-gray-400"
                    />
                </div>

                <div
                    v-if="filteredFriends.length === 0"
                    class="text-center text-gray-500 dark:text-gray-400 py-10"
                >
                    Tidak ada teman ditemukan.
                </div>

                <div class="divide-y divide-gray-100 dark:divide-gray-700">
                    <div
                        v-for="friend in filteredFriends"
                        :key="friend.id"
                        class="flex items-center gap-4 py-4 first:pt-0"
                    >
                        <div
                            class="w-12 h-12 rounded-full bg-indigo-100 dark:bg-gray-600 flex items-center justify-center text-indigo-500 dark:text-gray-300 font-bold text-lg shadow-sm"
                        >
                            {{ friend.name.charAt(0).toUpperCase() }}
                        </div>
                        <div>
                            <h3 class="font-bold text-gray-900 dark:text-white">
                                {{ friend.name }}
                            </h3>
                            <p class="text-xs text-gray-500 dark:text-gray-400">
                                {{ friend.email }}
                            </p>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Navigation -->
            <nav
                class="bg-white dark:bg-gray-700 border-t border-gray-200 dark:border-gray-600 px-6 py-2 pb-5 z-20"
            >
                <ul class="flex justify-between items-center">
                    <li class="flex-1">
                        <Link
                            :class="{
                                'text-indigo-600':
                                    route().current('student.dashboard'),
                                'text-gray-500 dark:text-gray-400':
                                    !route().current('student.dashboard'),
                            }"
                            class="flex flex-col items-center justify-center hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors group"
                            :href="route('student.dashboard')"
                        >
                            <ListTodo class="w-6 h-6 mb-1" />
                            <span class="text-[10px] font-medium"
                                >Kebiasaan</span
                            >
                        </Link>
                    </li>
                    <li class="flex-1">
                        <Link
                            :class="{
                                'text-indigo-600': route().current(
                                    'student.friends.index',
                                ),
                                'text-gray-500 dark:text-gray-400':
                                    !route().current('student.friends.index'),
                            }"
                            class="flex flex-col items-center justify-center hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors group"
                            :href="route('student.friends.index')"
                        >
                            <Users class="w-6 h-6 mb-1" />
                            <span class="text-[10px] font-medium">Teman</span>
                        </Link>
                    </li>
                    <li class="flex-1">
                        <Link
                            :class="{
                                'text-indigo-600': false,
                                'text-gray-500 dark:text-gray-400': true,
                            }"
                            class="flex flex-col items-center justify-center hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors group"
                            href="#"
                        >
                            <Home class="w-6 h-6 mb-1" />
                            <span class="text-[10px] font-medium">Beranda</span>
                        </Link>
                    </li>
                    <li class="flex-1">
                        <Link
                            :class="{
                                'text-indigo-600': route().current(
                                    'student.profile.edit',
                                ),
                                'text-gray-500 dark:text-gray-400':
                                    !route().current('student.profile.edit'),
                            }"
                            class="flex flex-col items-center justify-center hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors group"
                            :href="route('student.profile.edit')"
                        >
                            <User class="w-6 h-6 mb-1" />
                            <span class="text-[10px] font-medium">Profil</span>
                        </Link>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</template>

<style scoped>
.scrollbar-hide::-webkit-scrollbar {
    display: none;
}
.scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
}
</style>
