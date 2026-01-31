<?php

namespace App\Filament\Widgets;

use App\Models\Classroom;
use App\Models\GeneticType;
use App\Models\HabitCategory;
use App\Models\User;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('Total Users', User::count())
                ->description('All registered users')
                ->descriptionIcon('heroicon-m-users')
                ->color('primary')
                ->url('/admin/users'), // Assuming generic user resource or just for info. If no resource, link might be dead. Let's use /admin/mentor or /admin/student for specificity if needed, but user asked for "User".

            Stat::make('Mentors', User::role('mentor')->count())
                ->description('Active Mentors')
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->color('success'),

            Stat::make('Students', User::role('student')->count())
                ->description('Active students')
                ->descriptionIcon('heroicon-m-user-group')
                ->color('warning')
                ->url('/admin/student'),

            Stat::make('Classrooms', Classroom::count())
                ->description('Total classes')
                ->descriptionIcon('heroicon-m-home-modern')
                ->color('info')
                ->url('/admin/classrooms'),

            Stat::make('Genetic Types', GeneticType::count())
                ->description('Available types')
                ->descriptionIcon('heroicon-m-beaker')
                ->color('danger')
                ->url('/admin/genetic-types'),

            Stat::make('Habit Categories', HabitCategory::count())
                ->description('Categories defined')
                ->descriptionIcon('heroicon-m-tag')
                ->color('gray')
                ->url('/admin/habit-categories'),
        ];
    }
}
