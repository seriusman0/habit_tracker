<script setup>
import { ref } from "vue";
import ApplicationLogo from "@/Components/ApplicationLogo.vue";
import Dropdown from "@/Components/Dropdown.vue";
import DropdownLink from "@/Components/DropdownLink.vue";
import NavLink from "@/Components/NavLink.vue";
import ResponsiveNavLink from "@/Components/ResponsiveNavLink.vue";
import { Link } from "@inertiajs/vue3";
import { Home, Users, User, Globe } from "lucide-vue-next";

const showingNavigationDropdown = ref(false);
</script>

<template>
    <div>
        <div class="min-h-screen bg-gray-100 dark:bg-gray-900">
            <!-- Page Heading -->
            <header
                class="bg-white shadow dark:bg-gray-800"
                v-if="$slots.header"
            >
                <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
                    <slot name="header" />
                </div>
            </header>

            <!-- Page Content -->
            <main class="mb-20">
                <slot />
            </main>

            <!-- Bottom Navigation for Mobile (Always Visible now) -->
            <nav
                class="fixed bottom-0 left-1/2 -translate-x-1/2 z-50 w-full max-w-md border-t border-gray-200 bg-white dark:border-gray-600 dark:bg-gray-800"
            >
                <div class="mx-auto grid h-16 w-full grid-cols-4 font-medium">
                    <!-- Changed to 4 columns -->
                    <Link
                        :href="route('habits.index')"
                        class="group inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-700"
                    >
                        <Home
                            class="mb-1 h-6 w-6 text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500"
                            :class="{
                                'text-blue-600 dark:text-blue-500':
                                    route().current('habits.*'),
                            }"
                        />
                        <span
                            class="text-xs text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500"
                            :class="{
                                'text-blue-600 dark:text-blue-500':
                                    route().current('habits.*'),
                            }"
                            >Habits</span
                        >
                    </Link>
                    <Link
                        :href="route('friendships.index')"
                        class="group inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-700"
                    >
                        <Users
                            class="mb-1 h-6 w-6 text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500"
                            :class="{
                                'text-blue-600 dark:text-blue-500':
                                    route().current('friendships.*'),
                            }"
                        />
                        <span
                            class="text-xs text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500"
                            :class="{
                                'text-blue-600 dark:text-blue-500':
                                    route().current('friendships.*'),
                            }"
                            >Friends</span
                        >
                    </Link>
                    <Link
                        :href="route('social.index')"
                        class="group inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-700"
                    >
                        <Globe
                            class="mb-1 h-6 w-6 text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500"
                            :class="{
                                'text-blue-600 dark:text-blue-500':
                                    route().current('social.*'),
                            }"
                        />
                        <span
                            class="text-xs text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500"
                            :class="{
                                'text-blue-600 dark:text-blue-500':
                                    route().current('social.*'),
                            }"
                            >Feed</span
                        >
                    </Link>
                    <Link
                        :href="route('profile.edit')"
                        class="group inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-700"
                    >
                        <User
                            class="mb-1 h-6 w-6 text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500"
                            :class="{
                                'text-blue-600 dark:text-blue-500':
                                    route().current('profile.*'),
                            }"
                        />
                        <span
                            class="text-xs text-gray-500 dark:text-gray-400 group-hover:text-blue-600 dark:group-hover:text-blue-500"
                            :class="{
                                'text-blue-600 dark:text-blue-500':
                                    route().current('profile.*'),
                            }"
                            >Profile</span
                        >
                    </Link>
                </div>
            </nav>
        </div>
    </div>
</template>
