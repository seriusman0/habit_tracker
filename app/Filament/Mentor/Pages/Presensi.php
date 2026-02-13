<?php

namespace App\Filament\Mentor\Pages;

use Filament\Pages\Page;

class Presensi extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-clock';

    protected static string $view = 'filament.mentor.pages.presensi';

    protected static ?string $navigationLabel = 'Presensi';

    protected static ?string $title = 'Presensi';

    protected static ?string $slug = 'presensi';
}
