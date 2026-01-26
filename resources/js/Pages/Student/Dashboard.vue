<script setup>
import { Head, Link } from "@inertiajs/vue3";
import {
    Plus,
    Sun,
    ChevronUp,
    ChevronDown,
    Check,
    X,
    HeartHandshake, // Volunteer/Bermasyarakat -> HeartHandshake/Users
    Utensils, // Restaurant
    Moon, // Bedtime
    BookOpen, // School -> BookOpen/GraduationCap
    Laugh, // Sentiment Satisfied
    Meh, // Sentiment Neural
    Frown, // Sentiment Dissatisfied
    ListTodo, // Kebiasaan
    Users, // Teman
    Home, // Beranda
    User, // Profil
} from "lucide-vue-next";
import { ref } from "vue";

// State for toggling accordion
const openCategories = ref({
    "bangun-pagi": true,
    beribadah: false,
    "olah-raga": false,
    "makan-sehat": false,
    "gemar-belajar": false,
    bermasyarakat: false,
    "tidur-cepat": false,
});

const toggleCategory = (key) => {
    openCategories.value[key] = !openCategories.value[key];
};
</script>

<template>
    <Head title="Kebiasaanku" />

    <div
        class="bg-gray-200 dark:bg-gray-900 font-sans min-h-screen flex items-center justify-center p-4 selection:bg-indigo-500 selection:text-white"
    >
        <div
            class="w-full max-w-md bg-white dark:bg-gray-800 h-[850px] rounded-[30px] shadow-2xl overflow-hidden flex flex-col relative border border-gray-300 dark:border-gray-700"
        >
            <!-- Header -->
            <header
                class="bg-white dark:bg-gray-700 px-6 py-5 border-b border-gray-200 dark:border-gray-600 sticky top-0 z-20"
            >
                <h1 class="text-2xl font-bold text-gray-900 dark:text-gray-100">
                    Kebiasaanku
                </h1>
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
                        class="bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold py-2 px-3 rounded-lg shadow-sm flex items-center transition-colors"
                    >
                        <Plus class="w-4 h-4 mr-1" />
                        TAMBAH
                    </button>
                </div>

                <div class="space-y-3 pb-6">
                    <!-- Category: Bangun Pagi -->
                    <div
                        class="bg-white dark:bg-gray-700 rounded-xl p-4 shadow-sm flex flex-col group transition-all duration-300"
                    >
                        <div
                            @click="toggleCategory('bangun-pagi')"
                            class="flex items-center justify-between cursor-pointer w-full"
                        >
                            <div class="flex items-center gap-4">
                                <div
                                    class="w-10 h-10 rounded-full bg-amber-100 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400 flex items-center justify-center"
                                >
                                    <Sun class="w-6 h-6" />
                                </div>
                                <div>
                                    <h3
                                        class="text-sm font-bold text-gray-900 dark:text-gray-100 uppercase tracking-wide"
                                    >
                                        Bangun Pagi
                                    </h3>
                                    <p
                                        class="text-[10px] text-gray-500 dark:text-gray-400"
                                    >
                                        Siap memulai hari?
                                    </p>
                                </div>
                            </div>
                            <div class="text-indigo-600 transition-colors">
                                <component
                                    :is="
                                        openCategories['bangun-pagi']
                                            ? ChevronUp
                                            : ChevronDown
                                    "
                                    class="w-6 h-6"
                                />
                            </div>
                        </div>

                        <div
                            v-if="openCategories['bangun-pagi']"
                            class="mt-4 space-y-2 border-t border-gray-100 dark:border-gray-600 pt-3"
                        >
                            <div
                                class="flex items-center justify-between p-2 rounded-lg bg-green-50/50 dark:bg-green-900/10"
                            >
                                <span
                                    class="text-sm font-medium text-gray-900 dark:text-gray-100 line-through decoration-green-500/50 decoration-2 opacity-70"
                                    >Bangun Pagi jam 06:00</span
                                >
                                <div class="flex gap-2">
                                    <button
                                        aria-label="Berhasil"
                                        class="w-8 h-8 rounded-full bg-green-400 text-white shadow-sm flex items-center justify-center transition-all hover:scale-105"
                                    >
                                        <Check class="w-5 h-5" />
                                    </button>
                                    <button
                                        aria-label="Tidak Dilakukan"
                                        class="w-8 h-8 rounded-full bg-white dark:bg-gray-700 border-2 border-gray-100 dark:border-gray-600 text-gray-300 flex items-center justify-center opacity-50 cursor-not-allowed"
                                    >
                                        <X class="w-5 h-5" />
                                    </button>
                                </div>
                            </div>
                            <div
                                class="flex items-center justify-between p-2 rounded-lg bg-red-50/50 dark:bg-red-900/10"
                            >
                                <span
                                    class="text-sm font-medium text-gray-900 dark:text-gray-100 opacity-70"
                                    >Siap dan Berangkat ke Sekolah</span
                                >
                                <div class="flex gap-2">
                                    <button
                                        aria-label="Berhasil"
                                        class="w-8 h-8 rounded-full bg-white dark:bg-gray-700 border-2 border-gray-100 dark:border-gray-600 text-gray-300 flex items-center justify-center opacity-50 cursor-not-allowed"
                                    >
                                        <Check class="w-5 h-5" />
                                    </button>
                                    <button
                                        aria-label="Tidak Dilakukan"
                                        class="w-8 h-8 rounded-full bg-red-400 text-white shadow-sm flex items-center justify-center transition-all hover:scale-105"
                                    >
                                        <X class="w-5 h-5" />
                                    </button>
                                </div>
                            </div>
                            <div
                                class="flex items-center justify-between p-2 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors"
                            >
                                <span
                                    class="text-sm font-medium text-gray-900 dark:text-gray-100"
                                    >Sambut Guru/Tutor dengan Semangat</span
                                >
                                <div class="flex gap-2">
                                    <button
                                        aria-label="Mark as Done"
                                        class="w-8 h-8 rounded-full bg-white dark:bg-gray-700 border-2 border-green-200 dark:border-green-800 text-green-400 hover:bg-green-400 hover:text-white dark:hover:bg-green-600 transition-all flex items-center justify-center"
                                    >
                                        <Check class="w-5 h-5" />
                                    </button>
                                    <button
                                        aria-label="Mark as Missed"
                                        class="w-8 h-8 rounded-full bg-white dark:bg-gray-700 border-2 border-red-200 dark:border-red-800 text-red-400 hover:bg-red-400 hover:text-white dark:hover:bg-red-600 transition-all flex items-center justify-center"
                                    >
                                        <X class="w-5 h-5" />
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Category: Beribadah -->
                    <div
                        class="bg-white dark:bg-gray-700 rounded-xl p-4 shadow-sm flex flex-col group cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors"
                    >
                        <div
                            @click="toggleCategory('beribadah')"
                            class="flex items-center justify-between w-full"
                        >
                            <div class="flex items-center gap-4">
                                <div
                                    class="w-10 h-10 rounded-full bg-purple-100 dark:bg-purple-900/30 text-purple-600 dark:text-purple-400 flex items-center justify-center"
                                >
                                    <HeartHandshake class="w-6 h-6" />
                                </div>
                                <div>
                                    <h3
                                        class="text-sm font-bold text-gray-900 dark:text-gray-100 uppercase tracking-wide"
                                    >
                                        Beribadah
                                    </h3>
                                    <p
                                        class="text-[10px] text-gray-500 dark:text-gray-400"
                                    >
                                        Waktunya berdoa
                                    </p>
                                </div>
                            </div>
                            <div
                                class="text-gray-500 dark:text-gray-400 hover:text-indigo-600 transition-colors"
                            >
                                <component
                                    :is="
                                        openCategories['beribadah']
                                            ? ChevronUp
                                            : ChevronDown
                                    "
                                    class="w-6 h-6"
                                />
                            </div>
                        </div>
                        <div
                            v-if="openCategories['beribadah']"
                            class="mt-4 space-y-2 border-t border-gray-100 dark:border-gray-600 pt-3"
                        >
                            <div
                                class="flex items-center justify-between p-2 rounded-lg hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors"
                            >
                                <span
                                    class="text-sm font-medium text-gray-900 dark:text-gray-100"
                                    >Shalat Tepat Waktu</span
                                >
                                <div class="flex gap-2">
                                    <button
                                        class="w-8 h-8 rounded-full bg-white dark:bg-gray-700 border-2 border-green-200 dark:border-green-800 text-green-400 hover:bg-green-400 hover:text-white transition-all flex items-center justify-center"
                                    >
                                        <Check class="w-5 h-5" />
                                    </button>
                                    <button
                                        class="w-8 h-8 rounded-full bg-white dark:bg-gray-700 border-2 border-red-200 dark:border-red-800 text-red-400 hover:bg-red-400 hover:text-white transition-all flex items-center justify-center"
                                    >
                                        <X class="w-5 h-5" />
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Other Categories can continue similarly... For MVP just implementing a few based on the template -->
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
                    <div class="flex justify-around gap-4">
                        <button class="flex flex-col items-center gap-2 group">
                            <div
                                class="w-12 h-12 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center text-green-600 dark:text-green-400 group-hover:bg-green-200 dark:group-hover:bg-green-900/50 transition-colors"
                            >
                                <Laugh class="w-7 h-7" />
                            </div>
                            <span
                                class="text-xs font-medium text-gray-500 dark:text-gray-400 group-hover:text-green-600 dark:group-hover:text-green-400"
                                >Senang</span
                            >
                        </button>
                        <button class="flex flex-col items-center gap-2 group">
                            <div
                                class="w-12 h-12 rounded-full bg-yellow-100 dark:bg-yellow-900/30 flex items-center justify-center text-yellow-600 dark:text-yellow-400 group-hover:bg-yellow-200 dark:group-hover:bg-yellow-900/50 transition-colors"
                            >
                                <Meh class="w-7 h-7" />
                            </div>
                            <span
                                class="text-xs font-medium text-gray-500 dark:text-gray-400 group-hover:text-yellow-600 dark:group-hover:text-yellow-400"
                                >Biasa</span
                            >
                        </button>
                        <button class="flex flex-col items-center gap-2 group">
                            <div
                                class="w-12 h-12 rounded-full bg-red-100 dark:bg-red-900/30 flex items-center justify-center text-red-600 dark:text-red-400 group-hover:bg-red-200 dark:group-hover:bg-red-900/50 transition-colors"
                            >
                                <Frown class="w-7 h-7" />
                            </div>
                            <span
                                class="text-xs font-medium text-gray-500 dark:text-gray-400 group-hover:text-red-600 dark:group-hover:text-red-400"
                                >Sedih</span
                            >
                        </button>
                    </div>
                </div>
            </main>

            <!-- Navigation -->
            <nav
                class="bg-white dark:bg-gray-700 border-t border-gray-200 dark:border-gray-600 px-6 py-2 pb-5 z-20"
            >
                <ul class="flex justify-between items-center">
                    <li class="flex-1">
                        <a
                            class="flex flex-col items-center justify-center text-indigo-600 group"
                            href="#"
                        >
                            <ListTodo class="w-6 h-6 mb-1" />
                            <span class="text-[10px] font-medium"
                                >Kebiasaan</span
                            >
                        </a>
                    </li>
                    <li class="flex-1">
                        <a
                            class="flex flex-col items-center justify-center text-gray-500 dark:text-gray-400 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors group"
                            href="#"
                        >
                            <Users class="w-6 h-6 mb-1" />
                            <span class="text-[10px] font-medium">Teman</span>
                        </a>
                    </li>
                    <li class="flex-1">
                        <a
                            class="flex flex-col items-center justify-center text-gray-500 dark:text-gray-400 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors group"
                            href="#"
                        >
                            <Home class="w-6 h-6 mb-1" />
                            <span class="text-[10px] font-medium">Beranda</span>
                        </a>
                    </li>
                    <li class="flex-1">
                        <a
                            class="flex flex-col items-center justify-center text-gray-500 dark:text-gray-400 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors group"
                            href="#"
                        >
                            <User class="w-6 h-6 mb-1" />
                            <span class="text-[10px] font-medium">Profil</span>
                        </a>
                    </li>
                </ul>
            </nav>
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
