<x-filament-widgets::widget>
    <x-filament::card>
        <div class="flex items-center justify-between mb-4">
            <h3 class="text-lg font-bold tracking-tight text-gray-950 dark:text-white">
                Rekapitulasi Mingguan
            </h3>
            <div class="text-sm text-gray-500 flex items-center gap-2">
                <x-filament::icon icon="heroicon-o-calendar-days" class="w-5 h-5 text-gray-400" />
                @if($weekStart && $weekEnd)
                    {{ $weekStart->translatedFormat('d M Y') }} – {{ $weekEnd->translatedFormat('d M Y') }}
                @endif
            </div>
        </div>

        <div class="overflow-x-auto ring-1 ring-gray-950/5 rounded-lg dark:ring-white/10">
            <table class="w-full text-left text-sm whitespace-nowrap">
                <thead class="bg-gray-50 dark:bg-white/5">
                    <tr>
                        <th class="px-4 py-3 font-medium text-gray-950 dark:text-white">Habit</th>
                        <th class="px-4 py-3 font-medium text-gray-950 dark:text-white text-center">Sen</th>
                        <th class="px-4 py-3 font-medium text-gray-950 dark:text-white text-center">Sel</th>
                        <th class="px-4 py-3 font-medium text-gray-950 dark:text-white text-center">Rab</th>
                        <th class="px-4 py-3 font-medium text-gray-950 dark:text-white text-center">Kam</th>
                        <th class="px-4 py-3 font-medium text-gray-950 dark:text-white text-center">Jum</th>
                        <th class="px-4 py-3 font-medium text-gray-950 dark:text-white text-center">Sab</th>
                        <th class="px-4 py-3 font-medium text-gray-950 dark:text-white text-center">Min</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 dark:divide-white/5">
                    @forelse ($habitsData as $habit)
                        <tr>
                            <td class="px-4 py-3 text-gray-950 dark:text-white font-medium">
                                {{ $habit['title'] }}
                                @if($habit['frequency'] === 'weekly')
                                    <span class="ml-2 inline-flex items-center rounded-md bg-indigo-50 px-2 py-1 text-xs font-medium text-indigo-700 ring-1 ring-inset ring-indigo-700/10">
                                        Mingguan
                                    </span>
                                @endif
                            </td>
                            
                            @php
                                $daysKeys = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
                            @endphp
                            @foreach ($daysKeys as $dayKey)
                                <td class="px-4 py-3 text-center">
                                    @if ($habit['frequency'] === 'weekly' && $dayKey !== 'monday')
                                        <!-- Blanking out non-Monday days for Weekly format -->
                                        <div class="flex justify-center">
                                            <div class="w-2 h-px bg-gray-300 dark:bg-gray-700"></div>
                                        </div>
                                    @else
                                        @php
                                            $status = $habit['days'][$dayKey];
                                        @endphp

                                        @if ($status === 'completed')
                                            <span class="inline-flex justify-center items-center w-6 h-6 rounded-full bg-emerald-100 text-emerald-600 dark:bg-emerald-500/20 dark:text-emerald-400" title="Melakukan">
                                                <x-filament::icon icon="heroicon-m-check" class="w-4 h-4" />
                                            </span>
                                        @elseif ($status === 'failed' || $status === 'skipped')
                                            <span class="inline-flex justify-center items-center w-6 h-6 rounded-full bg-rose-100 text-rose-600 dark:bg-rose-500/20 dark:text-rose-400" title="Tidak Melakukan">
                                                <x-filament::icon icon="heroicon-m-x-mark" class="w-4 h-4" />
                                            </span>
                                        @else
                                            <span class="inline-flex justify-center items-center w-6 h-6 rounded-full bg-gray-100 text-gray-400 dark:bg-white/5 dark:text-gray-500" title="Kosong">
                                                <x-filament::icon icon="heroicon-m-minus" class="w-4 h-4" />
                                            </span>
                                        @endif
                                    @endif
                                </td>
                            @endforeach
                        </tr>
                    @empty
                        <tr>
                            <td colspan="8" class="px-4 py-8 text-center text-gray-500 dark:text-gray-400">
                                Belum ada habit yang ditugaskan kepada siswa ini.
                            </td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </x-filament::card>
</x-filament-widgets::widget>
