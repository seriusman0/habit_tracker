<script setup>
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ListTodo, Users, Home, User, LogOut, Save } from "lucide-vue-next";
import { computed } from "vue";

const user = usePage().props.auth.user;

const form = useForm({
    name: user.name,
    username: user.username || "",
    email: user.email,
    current_password: "",
    password: "",
    password_confirmation: "",
});

const submit = () => {
    form.patch(route("student.profile.update"), {
        onSuccess: () => {
            form.reset("current_password", "password", "password_confirmation");
        },
    });
};

const logout = () => {
    useForm({}).post(route("logout"));
};
</script>

<template>
    <Head title="Profil Saya" />

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
                    Profil Saya
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
                <section
                    class="bg-white dark:bg-gray-700 rounded-xl p-5 shadow-sm mb-6"
                >
                    <div class="flex flex-col items-center mb-6">
                        <div
                            class="w-24 h-24 rounded-full bg-indigo-100 dark:bg-gray-600 flex items-center justify-center text-indigo-500 dark:text-gray-300 mb-3 text-2xl font-bold border-4 border-white dark:border-gray-500 shadow-md"
                        >
                            {{ user.name.charAt(0).toUpperCase() }}
                        </div>
                        <h2
                            class="text-xl font-bold text-gray-900 dark:text-white"
                        >
                            {{ user.name }}
                        </h2>
                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            {{ user.email }}
                        </p>
                    </div>

                    <form @submit.prevent="submit" class="space-y-4">
                        <div>
                            <label
                                class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1"
                                >Nama Lengkap</label
                            >
                            <input
                                v-model="form.name"
                                type="text"
                                class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-indigo-500 focus:border-indigo-500"
                                required
                            />
                            <div
                                v-if="form.errors.name"
                                class="text-red-500 text-xs mt-1"
                            >
                                {{ form.errors.name }}
                            </div>
                        </div>

                        <div>
                            <label
                                class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1"
                                >Username</label
                            >
                            <input
                                v-model="form.username"
                                type="text"
                                class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-indigo-500 focus:border-indigo-500"
                                required
                            />
                            <div
                                v-if="form.errors.username"
                                class="text-red-500 text-xs mt-1"
                            >
                                {{ form.errors.username }}
                            </div>
                        </div>

                        <div>
                            <label
                                class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1"
                                >Email</label
                            >
                            <input
                                v-model="form.email"
                                type="email"
                                class="w-full rounded-lg border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-indigo-500 focus:border-indigo-500"
                                required
                            />
                            <div
                                v-if="form.errors.email"
                                class="text-red-500 text-xs mt-1"
                            >
                                {{ form.errors.email }}
                            </div>
                        </div>

                        <div
                            class="border-t border-gray-200 dark:border-gray-600 pt-4 mt-4"
                        >
                            <h3
                                class="text-sm font-semibold text-gray-900 dark:text-white mb-3"
                            >
                                Ganti Password
                            </h3>

                            <div class="space-y-3">
                                <div>
                                    <label
                                        class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1"
                                        >Password Saat Ini</label
                                    >
                                    <input
                                        v-model="form.current_password"
                                        type="password"
                                        class="w-full text-sm rounded-lg border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-indigo-500 focus:border-indigo-500"
                                    />
                                    <div
                                        v-if="form.errors.current_password"
                                        class="text-red-500 text-xs mt-1"
                                    >
                                        {{ form.errors.current_password }}
                                    </div>
                                </div>
                                <div>
                                    <label
                                        class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1"
                                        >Password Baru</label
                                    >
                                    <input
                                        v-model="form.password"
                                        type="password"
                                        class="w-full text-sm rounded-lg border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-indigo-500 focus:border-indigo-500"
                                    />
                                    <div
                                        v-if="form.errors.password"
                                        class="text-red-500 text-xs mt-1"
                                    >
                                        {{ form.errors.password }}
                                    </div>
                                </div>
                                <div>
                                    <label
                                        class="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1"
                                        >Konfirmasi Password</label
                                    >
                                    <input
                                        v-model="form.password_confirmation"
                                        type="password"
                                        class="w-full text-sm rounded-lg border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-indigo-500 focus:border-indigo-500"
                                    />
                                </div>
                            </div>
                        </div>

                        <div class="pt-2">
                            <button
                                :disabled="form.processing"
                                type="submit"
                                class="w-full flex justify-center py-2 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 disabled:opacity-50 transition-colors"
                            >
                                <Save class="w-4 h-4 mr-2" />
                                Simpan Perubahan
                            </button>
                            <div
                                v-if="form.recentlySuccessful"
                                class="text-green-500 text-xs text-center mt-2"
                            >
                                Profil berhasil diperbarui!
                            </div>
                        </div>
                    </form>
                </section>
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
