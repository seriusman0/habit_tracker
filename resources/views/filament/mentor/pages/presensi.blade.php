<x-filament-panels::page>
    <div class="bg-white dark:bg-gray-900 p-6 rounded-xl shadow-sm border border-gray-200 dark:border-gray-800">
        <h3 class="text-lg font-bold mb-4">Pengajuan Kehadiran: {{ now()->format('d M Y') }}</h3>
        
        @if(empty($attendances))
            <div class="text-center text-gray-500 py-8">
                <p>Belum ada pengajuan kehadiran hari ini dari siswa di kelas Anda.</p>
            </div>
        @else
            <div class="overflow-x-auto">
                <table class="w-full text-sm text-left">
                    <thead class="bg-gray-50 dark:bg-gray-800/50 text-gray-700 dark:text-gray-300 border-b dark:border-gray-700">
                        <tr>
                            <th class="px-4 py-3 font-semibold">Nama Siswa</th>
                            <th class="px-4 py-3 font-semibold">Kelas</th>
                            <th class="px-4 py-3 font-semibold">Waktu</th>
                            <th class="px-4 py-3 font-semibold">Status</th>
                            <th class="px-4 py-3 font-semibold text-right">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($attendances as $attendance)
                        <tr wire:key="attendance-{{ $attendance['id'] }}" class="border-b dark:border-gray-800 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors">
                            <td class="px-4 py-3 font-medium text-gray-900 dark:text-gray-100">{{ $attendance['student']['name'] ?? 'Unknown' }}</td>
                            <td class="px-4 py-3 text-gray-600 dark:text-gray-400">{{ $attendance['classroom']['name'] ?? '-' }}</td>
                            <td class="px-4 py-3 text-gray-600 dark:text-gray-400">{{ \Carbon\Carbon::parse($attendance['created_at'] ?? now())->format('H:i') }}</td>
                            <td class="px-4 py-3">
                                @if($attendance['status'] === 'pending')
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-400">
                                        Menunggu
                                    </span>
                                @elseif($attendance['status'] === 'accepted')
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400">
                                        Hadir
                                    </span>
                                @else
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400">
                                        Ditolak
                                    </span>
                                @endif
                            </td>
                            <td class="px-4 py-3 text-right">
                                <div class="flex justify-end gap-2">
                                    @if($attendance['status'] === 'accepted')
                                        <button disabled
                                                class="inline-flex items-center gap-1 px-3 py-1.5 text-xs font-bold text-white bg-green-600 border border-green-600 rounded-md shadow-sm opacity-80 cursor-not-allowed dark:bg-green-700 dark:border-green-700">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 12.75 6 6 9-13.5" />
                                            </svg>
                                            Disetujui
                                        </button>
                                    @else
                                        <button wire:click="updateStatus({{ $attendance['id'] }}, 'accepted')" 
                                                class="inline-flex items-center gap-1 px-3 py-1.5 text-xs font-bold text-green-700 bg-green-50 border border-green-200 rounded-md shadow-sm hover:bg-green-100 dark:bg-green-900/20 dark:border-green-800 dark:text-green-400 dark:hover:bg-green-900/40 transition-all focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-1">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 12.75 6 6 9-13.5" />
                                            </svg>
                                            Hadir
                                        </button>
                                    @endif

                                    @if($attendance['status'] === 'rejected')
                                        <button disabled
                                                class="inline-flex items-center gap-1 px-3 py-1.5 text-xs font-bold text-white bg-red-600 border border-red-600 rounded-md shadow-sm opacity-80 cursor-not-allowed dark:bg-red-700 dark:border-red-700">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                                            </svg>
                                            Ditolak
                                        </button>
                                    @else
                                        <button wire:click="updateStatus({{ $attendance['id'] }}, 'rejected')" 
                                                class="inline-flex items-center gap-1 px-3 py-1.5 text-xs font-bold text-red-700 bg-red-50 border border-red-200 rounded-md shadow-sm hover:bg-red-100 dark:bg-red-900/20 dark:border-red-800 dark:text-red-400 dark:hover:bg-red-900/40 transition-all focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-1">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                                            </svg>
                                            Tolak
                                        </button>
                                    @endif
                                </div>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        @endif
    </div>
</x-filament-panels::page>
