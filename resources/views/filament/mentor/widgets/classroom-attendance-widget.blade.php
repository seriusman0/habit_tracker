<x-filament::widget>
    <x-filament::section>
        <div>
            <h2 class="text-lg font-bold mb-4">Presensi Hari Ini ({{ now()->format('d M Y') }})</h2>
            <div class="bg-gray-50 dark:bg-gray-900 p-4 rounded-lg">
                @if(empty($attendances))
                    <div class="text-center text-gray-500 dark:text-gray-400 py-6">
                        Belum ada pengajuan kehadiran hari ini.
                    </div>
                @else
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm text-left">
                            <thead class="bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300">
                                <tr>
                                    <th class="px-4 py-2 rounded-tl">Nama Siswa</th>
                                    <th class="px-4 py-2">Waktu</th>
                                    <th class="px-4 py-2">Status</th>
                                    <th class="px-4 py-2 rounded-tr text-right">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($attendances as $attendance)
                                <tr wire:key="att-{{ $attendance['id'] }}" class="border-b dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors">
                                    <td class="px-4 py-3 font-medium text-gray-900 dark:text-gray-100">
                                        {{ $attendance['student']['name'] ?? 'Unknown' }}
                                    </td>
                                    <td class="px-4 py-3 text-gray-500 dark:text-gray-400">
                                        {{ \Carbon\Carbon::parse($attendance['created_at'])->format('H:i') }}
                                    </td>
                                    <td class="px-4 py-3">
                                        @if($attendance['status'] === 'pending')
                                            <span class="px-2 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-400">
                                                Menunggu
                                            </span>
                                        @elseif($attendance['status'] === 'accepted')
                                            <span class="px-2 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400">
                                                Hadir
                                            </span>
                                        @else
                                            <span class="px-2 py-1 rounded-full text-xs font-semibold bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400">
                                                Ditolak
                                            </span>
                                        @endif
                                    </td>
                                    <td class="px-4 py-3 text-right">
                                        @if($attendance['status'] !== 'accepted')
                                            <button
                                                wire:click="updateStatus({{ $attendance['id'] }}, 'accepted')"
                                                wire:loading.attr="disabled"
                                                wire:target="updateStatus({{ $attendance['id'] }}, 'accepted')"
                                                class="inline-flex items-center gap-1 px-3 py-1.5 text-xs font-semibold text-green-700 bg-green-50 border border-green-200 rounded-md hover:bg-green-100 dark:bg-green-900/20 dark:border-green-800 dark:text-green-400 dark:hover:bg-green-900/40 transition-colors mr-1 focus:outline-none focus:ring-2 focus:ring-green-500">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 12.75 6 6 9-13.5" />
                                                </svg>
                                                Hadir
                                            </button>
                                        @endif
                                        @if($attendance['status'] !== 'rejected')
                                            <button
                                                wire:click="updateStatus({{ $attendance['id'] }}, 'rejected')"
                                                wire:loading.attr="disabled"
                                                wire:target="updateStatus({{ $attendance['id'] }}, 'rejected')"
                                                class="inline-flex items-center gap-1 px-3 py-1.5 text-xs font-semibold text-red-700 bg-red-50 border border-red-200 rounded-md hover:bg-red-100 dark:bg-red-900/20 dark:border-red-800 dark:text-red-400 dark:hover:bg-red-900/40 transition-colors focus:outline-none focus:ring-2 focus:ring-red-500">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                                                </svg>
                                                Tolak
                                            </button>
                                        @endif
                                    </td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                @endif
            </div>
        </div>
    </x-filament::section>
</x-filament::widget>
