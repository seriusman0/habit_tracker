<script setup>
import { Head, Link, useForm, router } from "@inertiajs/vue3";
import { ListTodo, Users, Home, User, LogOut, Search, Trophy, CalendarCheck } from "lucide-vue-next";
import { ref, watch } from "vue";
import debounce from "lodash/debounce";

const props = defineProps({
    friends: Object, // Sekarang berbentuk Paginated Object dari Laravel
    filters: Object,
});

const search = ref(props.filters.search || "");

// Watch input search dan trigger request ke server via Inertia dengan Debounce (Anti-Spam)
watch(search, debounce(function (value) {
    router.get(
        route('student.friends.index'),
        { search: value },
        { preserveState: true, replace: true }
    );
}, 300));

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
                <div>
                    <h1 class="text-2xl font-bold text-gray-900 dark:text-gray-100">
                        Teman Kelas
                    </h1>
                    <p class="text-xs text-gray-500 mt-1">Pencapaian Minggu Ini</p>
                </div>
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

                <!-- Empty State -->
                <div
                    v-if="!friends.data || friends.data.length === 0"
                    class="text-center text-gray-500 dark:text-gray-400 py-10"
                >
                    <div v-if="search" class="text-sm">
                        Tidak ada teman yang cocok dengan "{{ search }}".
                    </div>
                    <div v-else class="text-sm">
                        Belum ada teman di kelas ini. <br/>Atau kamu belum tergabung ke kelas manapun.
                    </div>
                </div>

                <!-- Cards Grid -->
                <div class="grid grid-cols-1 gap-4">
                    <div
                        v-for="friend in friends.data"
                        :key="friend.id"
                        class="bg-white dark:bg-gray-700/50 p-4 rounded-xl border border-gray-100 dark:border-gray-600 shadow-sm"
                    >
                        <div class="flex items-center gap-4 mb-4">
                            <div
                                class="w-12 h-12 rounded-full bg-indigo-100 dark:bg-gray-600 flex items-center justify-center text-indigo-500 dark:text-gray-300 font-bold text-lg shadow-sm shrink-0"
                            >
                                {{ friend.name.charAt(0).toUpperCase() }}
                            </div>
                            <div class="flex-1 min-w-0">
                                <h3 class="font-bold text-gray-900 dark:text-white truncate">
                                    {{ friend.name }}
                                </h3>
                            </div>
                            <div class="text-right shrink-0">
                                <p class="text-2xl font-black text-indigo-600 dark:text-indigo-400">
                                    {{ friend.weekly_summary ? friend.weekly_summary.progress_percentage : 0 }}<span class="text-sm">%</span>
                                </p>
                            </div>
                        </div>

                        <!-- Progress Bar Base -->
                        <div class="w-full bg-gray-200 rounded-full h-2 mb-4 dark:bg-gray-700 overflow-hidden">
                            <div class="bg-indigo-600 h-2 rounded-full transition-all duration-500 ease-out" 
                                 :style="`width: ${friend.weekly_summary ? friend.weekly_summary.progress_percentage : 0}%`"></div>
                        </div>

                        <!-- Stats Fraction -->
                        <div class="grid grid-cols-2 gap-2 text-xs text-gray-600 dark:text-gray-300">
                            <div class="flex items-center gap-1.5 bg-gray-50 dark:bg-gray-800 px-2 py-1.5 rounded-md border border-gray-100 dark:border-gray-600/50">
                                <ListTodo class="w-3.5 h-3.5 text-gray-400" />
                                <span>Daily: <strong class="text-gray-900 dark:text-white">{{ friend.weekly_summary ? friend.weekly_summary.daily_completed : 0 }}</strong> / {{ friend.weekly_summary ? friend.weekly_summary.daily_expected : 0 }}</span>
                            </div>
                            <div class="flex items-center gap-1.5 bg-gray-50 dark:bg-gray-800 px-2 py-1.5 rounded-md border border-gray-100 dark:border-gray-600/50">
                                <CalendarCheck class="w-3.5 h-3.5 text-gray-400" />
                                <span>Weekly: <strong class="text-gray-900 dark:text-white">{{ friend.weekly_summary ? friend.weekly_summary.weekly_completed : 0 }}</strong> / {{ friend.weekly_summary ? friend.weekly_summary.weekly_expected : 0 }}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Server Pagination Links -->
                <div v-if="friends.links && friends.links.length > 3" class="mt-6 flex justify-center flex-wrap gap-1">
                    <template v-for="(link, p) in friends.links" :key="p">
                        <div v-if="link.url === null" 
                             class="mb-1 mr-1 px-3 py-2 text-sm text-gray-400 border rounded dark:border-gray-600"
                             v-html="link.label"></div>
                        <Link v-else
                              class="mb-1 mr-1 px-3 py-2 text-sm border rounded focus:text-indigo-500 focus:border-indigo-500 hover:bg-gray-100 dark:hover:bg-gray-600 dark:border-gray-600 dark:text-white"
                              :class="{ 'bg-indigo-50 dark:bg-indigo-900/40 text-indigo-600 dark:text-indigo-300 font-bold border-indigo-300 dark:border-indigo-500': link.active }"
                              :href="link.url"
                              v-html="link.label"></Link>
                    </template>
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
