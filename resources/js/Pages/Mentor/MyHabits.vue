<script setup>
import { Head, Link, useForm, router } from "@inertiajs/vue3";
import {
    Plus,
    Sun,
    ChevronUp,
    ChevronDown,
    Check,
    X,
    HeartHandshake,
    Utensils,
    Moon,
    BookOpen,
    Laugh,
    Meh,
    Frown,
    ListTodo,
    Users,
    Home,
    User,
    Circle,
    LogOut,
    ArrowLeft,
} from "lucide-vue-next";
import { ref, computed } from "vue";

const props = defineProps({
    categories: Array,
    todaysReflection: Object,
});

// State for toggling accordion
const openCategories = ref({});

// Initialize open state (open first one by default if exists)
if (props.categories.length > 0) {
    openCategories.value[props.categories[0].id || "default"] = true;
}

const toggleCategory = (key) => {
    // Use ID as key, fall back to 'default' for uncategorized
    const id = key || "default";
    openCategories.value[id] = !openCategories.value[id];
};

// Toggle Habit Status
const toggleHabit = (habit, status) => {
    router.post(
        route("mentor.my-habits.toggle", habit.id),
        {
            status: status,
        },
        {
            preserveScroll: true,
            onSuccess: () => {
                // Optimistic update handled by Inertia reload
            },
        },
    );
};

// Reflection Logic (Placeholder for Mentor or reuse logic)
// For now, we reuse the UI but maybe disable the action or route it correctly if needed.
// Student controller had 'student.reflections.store'.
// We haven't implemented Mentor reflection store yet.
// Disabling for MVP or linking to existing if available.
const setMood = (mood) => {
    // router.post(
    //     route("mentor.reflections.store"),
    //     { mood: mood },
    //     { preserveScroll: true },
    // );
    alert("Fitur refleksi untuk mentor akan segera hadir!");
};

const isMoodActive = (mood) => {
    return props.todaysReflection?.mood === mood;
};

// Add Habit Modal Logic (Simple Prompt for MVP)
const addHabit = () => {
    const title = prompt("Nama kebiasaan baru:");
    if (title) {
        const category = prompt("Kategori (opsional):");
        router.post(route("mentor.my-habits.store"), {
            title: title,
            category_name: category,
            color: "bg-indigo-500", // Default
            frequency: "daily",
        });
    }
};

// Icon mapping helper (simplified)
const getIcon = (categoryName) => {
    const lower = categoryName.toLowerCase();
    if (lower.includes("bangun") || lower.includes("pagi")) return Sun;
    if (lower.includes("ibadah") || lower.includes("doa"))
        return HeartHandshake;
    if (lower.includes("makan") || lower.includes("sehat")) return Utensils;
    if (lower.includes("tidur")) return Moon;
    if (lower.includes("belajar") || lower.includes("sekolah")) return BookOpen;
    return Circle; // Default
};

const logout = () => {
    useForm({}).post(route("logout"));
};
</script>

<template>
    <Head title="Kebiasaanku (Mentor)" />

    <div
        class="bg-gray-200 dark:bg-gray-900 font-sans min-h-screen flex items-center justify-center p-4 selection:bg-amber-500 selection:text-white"
    >
        <div
            class="w-full max-w-md bg-white dark:bg-gray-800 h-[850px] rounded-[30px] shadow-2xl overflow-hidden flex flex-col relative border border-gray-300 dark:border-gray-700"
        >
            <!-- Header -->
            <header
                class="bg-white dark:bg-gray-700 px-6 py-5 border-b border-gray-200 dark:border-gray-600 sticky top-0 z-20 flex justify-between items-center"
            >
                <div class="flex items-center gap-3">
                    <!-- Back to Filament Dashboard -->
                    <a
                        href="/mentor"
                        class="text-gray-500 hover:text-amber-500 transition-colors"
                    >
                        <ArrowLeft class="w-6 h-6" />
                    </a>
                    <h1
                        class="text-2xl font-bold text-gray-900 dark:text-gray-100"
                    >
                        Kebiasaanku
                    </h1>
                </div>
                <!-- Mentor Avatar or generic icon -->
                <div
                    class="w-8 h-8 rounded-full bg-amber-100 flex items-center justify-center text-amber-600 font-bold"
                >
                    M
                </div>
            </header>

            <!-- Main Content -->
            <main class="flex-1 overflow-y-auto px-6 py-6 scrollbar-hide">
                <div class="flex items-center justify-between mb-4">
                    <h2
                        class="text-lg font-semibold text-gray-900 dark:text-gray-100"
                    >
                        Kategori Kebiasaan
                    </h2>
                    <button
                        @click="addHabit"
                        class="bg-amber-600 hover:bg-amber-700 text-white text-xs font-bold py-2 px-3 rounded-lg shadow-sm flex items-center transition-colors"
                    >
                        <Plus class="w-4 h-4 mr-1" />
                        TAMBAH
                    </button>
                </div>

                <div class="space-y-3 pb-6">
                    <div
                        v-if="categories.length === 0"
                        class="text-center text-gray-500 py-4"
                    >
                        Belum ada kebiasaan. Tambahkan sekarang!
                    </div>

                    <!-- Categories Loop -->
                    <div
                        v-for="category in categories"
                        :key="category.id || 'default'"
                        class="bg-white dark:bg-gray-700 rounded-xl p-4 shadow-sm flex flex-col group transition-all duration-300"
                    >
                        <div
                            @click="toggleCategory(category.id)"
                            class="flex items-center justify-between cursor-pointer w-full"
                        >
                            <div class="flex items-center gap-4">
                                <div
                                    class="w-10 h-10 rounded-full bg-amber-100 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400 flex items-center justify-center"
                                >
                                    <component
                                        :is="getIcon(category.name)"
                                        class="w-6 h-6"
                                    />
                                </div>
                                <div>
                                    <h3
                                        class="text-sm font-bold text-gray-900 dark:text-gray-100 uppercase tracking-wide"
                                    >
                                        {{ category.name }}
                                    </h3>
                                    <p
                                        v-if="category.habits"
                                        class="text-[10px] text-gray-500 dark:text-gray-400"
                                    >
                                        {{ category.habits.length }} kebiasaan
                                    </p>
                                </div>
                            </div>
                            <div class="text-amber-600 transition-colors">
                                <component
                                    :is="
                                        openCategories[category.id || 'default']
                                            ? ChevronUp
                                            : ChevronDown
                                    "
                                    class="w-6 h-6"
                                />
                            </div>
                        </div>

                        <div
                            v-if="openCategories[category.id || 'default']"
                            class="mt-4 space-y-2 border-t border-gray-100 dark:border-gray-600 pt-3"
                        >
                            <div
                                v-for="habit in category.habits"
                                :key="habit.id"
                                class="flex items-center justify-between p-2 rounded-lg transition-colors"
                                :class="{
                                    'bg-green-50/50 dark:bg-green-900/10':
                                        habit.todays_log?.status ===
                                        'completed',
                                    'bg-red-50/50 dark:bg-red-900/10':
                                        habit.todays_log?.status === 'skipped',
                                    'hover:bg-gray-50 dark:hover:bg-gray-600':
                                        !habit.todays_log,
                                }"
                            >
                                <span
                                    class="text-sm font-medium text-gray-900 dark:text-gray-100"
                                    :class="{
                                        'line-through decoration-green-500/50 decoration-2 opacity-70':
                                            habit.todays_log?.status ===
                                            'completed',
                                        'opacity-70':
                                            habit.todays_log?.status ===
                                            'skipped',
                                    }"
                                    >{{ habit.title }}</span
                                >
                                <div class="flex gap-2">
                                    <button
                                        @click="toggleHabit(habit, 'completed')"
                                        aria-label="Berhasil"
                                        class="w-8 h-8 rounded-full border-2 transition-all flex items-center justify-center hover:scale-105"
                                        :class="{
                                            'bg-green-400 text-white border-transparent':
                                                habit.todays_log?.status ===
                                                'completed',
                                            'bg-white dark:bg-gray-700 border-green-200 dark:border-green-800 text-green-400 hover:bg-green-400 hover:text-white':
                                                habit.todays_log?.status !==
                                                'completed',
                                        }"
                                    >
                                        <Check class="w-5 h-5" />
                                    </button>
                                    <button
                                        @click="toggleHabit(habit, 'skipped')"
                                        aria-label="Tidak Dilakukan"
                                        class="w-8 h-8 rounded-full border-2 transition-all flex items-center justify-center hover:scale-105"
                                        :class="{
                                            'bg-red-400 text-white border-transparent':
                                                habit.todays_log?.status ===
                                                'skipped',
                                            'bg-white dark:bg-gray-700 border-red-200 dark:border-red-800 text-red-400 hover:bg-red-400 hover:text-white':
                                                habit.todays_log?.status !==
                                                'skipped',
                                        }"
                                    >
                                        <X class="w-5 h-5" />
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Refleksi Hari Ini -->
                <div
                    class="bg-white dark:bg-gray-700 rounded-xl p-5 shadow-sm mt-2 mb-6"
                >
                    <h3
                        class="text-lg font-bold text-gray-900 dark:text-gray-100 mb-2 text-center"
                    >
                        Refleksi Hari Ini
                    </h3>
                    <p
                        class="text-sm text-gray-500 dark:text-gray-400 mb-4 text-center"
                    >
                        Bagaimana perasaanmu hari ini?
                    </p>
                    <div
                        class="flex justify-around gap-4 opacity-50 cursor-not-allowed"
                    >
                        <!-- Happy -->
                        <div class="flex flex-col items-center gap-2 group">
                            <div
                                class="w-12 h-12 rounded-full flex items-center justify-center bg-green-100 text-green-600"
                            >
                                <Laugh class="w-7 h-7" />
                            </div>
                        </div>

                        <!-- Neutral -->
                        <div class="flex flex-col items-center gap-2 group">
                            <div
                                class="w-12 h-12 rounded-full flex items-center justify-center bg-yellow-100 text-yellow-600"
                            >
                                <Meh class="w-7 h-7" />
                            </div>
                        </div>

                        <!-- Sad -->
                        <div class="flex flex-col items-center gap-2 group">
                            <div
                                class="w-12 h-12 rounded-full flex items-center justify-center bg-red-100 text-red-600"
                            >
                                <Frown class="w-7 h-7" />
                            </div>
                        </div>
                    </div>
                    <p class="text-xs text-center text-gray-400 mt-2">
                        (Refleksi segera hadir)
                    </p>
                </div>
            </main>

            <!-- NO BOTTOM NAVIGATION FOR MENTOR -->
        </div>
    </div>
</template>

<style scoped>
/* Hide scrollbar for Chrome, Safari and Opera */
.scrollbar-hide::-webkit-scrollbar {
    display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.scrollbar-hide {
    -ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
}
</style>
