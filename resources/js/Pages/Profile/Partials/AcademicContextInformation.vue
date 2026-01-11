<script setup>
import { BookOpenIcon } from "@heroicons/vue/24/outline";
</script>

<template>
    <section>
        <header class="flex items-center gap-2">
            <BookOpenIcon class="h-6 w-6 text-gray-400" />
            <h2 class="text-lg font-medium text-gray-900 dark:text-gray-100">
                Tentang Aplikasi & Konteks Akademis
            </h2>
        </header>

        <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
            Aplikasi ini dibangun sebagai bagian dari implementasi program
            pendidikan karakter nasional.
        </p>

        <div
            class="mt-6 border-l-4 border-blue-500 bg-blue-50 p-4 dark:border-blue-400 dark:bg-gray-700/50"
        >
            <p class="text-sm italic text-gray-600 dark:text-gray-300">
                "Implementasi Jurnal
                <strong class="text-blue-600 dark:text-blue-400"
                    >7 Kebiasaan Anak Indonesia Hebat</strong
                >
                Yang dibuat oleh Kemendiknas untuk sekolah jenjang SD, SMP,
                SMA."
            </p>
        </div>

        <div class="mt-6 text-sm text-gray-600 dark:text-gray-400">
            <p>
                Platform ini didesain khusus untuk mendukung murid jenjang
                <span class="font-semibold text-gray-800 dark:text-gray-200"
                    >SD, SMP, dan SMA</span
                >
                dalam mencatat dan memantau perkembangan kebiasaan positif
                mereka sehari-hari sesuai kurikulum yang berlaku.
            </p>
        </div>
    </section>
</template>
