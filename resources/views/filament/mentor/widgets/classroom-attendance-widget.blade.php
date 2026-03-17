<x-filament::widget>
    <x-filament::section>
        <div>
            <h2 class="text-lg font-bold mb-4">Presensi Hari Ini ({{ now()->format('d M Y') }})</h2>
            <div class="bg-gray-50 dark:bg-gray-900 p-4 rounded-lg">
                @if(empty($attendances))
                    <div class="text-center text-gray-500 py-4">Belum ada pengajuan kehadiran hari ini.</div>
                @else
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm text-left">
                            <thead class="bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300">
                                <tr>
                                    <th class="px-4 py-2 rounded-tl">Nama Siswa</th>
                                    <th class="px-4 py-2">Waktu Pengajuan</th>
                                    <th class="px-4 py-2">Status</th>
                                    <th class="px-4 py-2 rounded-tr">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($attendances as $attendance)
                                <tr wire:key="attendance-{{ $attendance['id'] }}" class="border-b dark:border-gray-700">
                                    <td class="px-4 py-3 font-medium">{{ $attendance['student']['name'] ?? 'Unknown' }}</td>
                                    <td class="px-4 py-3">{{ \Carbon\Carbon::parse($attendance['created_at'])->format('H:i') }}</td>
                                    <td class="px-4 py-3">
                                        @if($attendance['status'] === 'pending')
                                            <span class="px-2 py-1 rounded text-xs font-semibold bg-yellow-100 text-yellow-800 inline-block">Menunggu</span>
                                        @elseif($attendance['status'] === 'accepted')
                                            <span class="px-2 py-1 rounded text-xs font-semibold bg-green-100 text-green-800 inline-block">Hadir</span>
                                        @else
                                            <span class="px-2 py-1 rounded text-xs font-semibold bg-red-100 text-red-800 inline-block">Ditolak</span>
                                        @endif
                                    </td>
                                    <td class="px-4 py-3 min-w-[150px]">
                                        <button wire:click="updateStatus({{ $attendance['id'] }}, 'accepted')" class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded text-xs mr-2 transition-colors">
                                            Accept
                                        </button>
                                        <button wire:click="updateStatus({{ $attendance['id'] }}, 'rejected')" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-xs transition-colors">
                                            Reject
                                        </button>
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
