<x-filament-panels::page>
    <div class="mb-4">
        <h2 class="text-2xl font-bold tracking-tight">Laporan Performa: {{ $this->record->name }}</h2>
        <p class="text-gray-500 text-sm">Rekapitulasi pencapaian habit siswa dalam rentang waktu terukur.</p>
    </div>

    <!-- Area ini merender Widget (Stats dan Chart) yang telah didefinisikan pada getHeaderWidgets() di class Page -->
    @if (count($this->getHeaderWidgets()))
        <x-filament-widgets::widgets
            :columns="$this->getHeaderWidgetsColumns()"
            :data="$this->getWidgetData()"
            :widgets="$this->getHeaderWidgets()"
        />
    @endif
</x-filament-panels::page>
