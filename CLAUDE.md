# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

```bash
# Start all dev servers concurrently (PHP, queue, log tailing, Vite)
composer dev

# Run tests
composer test

# Run a single test file
./vendor/bin/pest tests/Feature/ExampleTest.php

# Build frontend assets
npm run build

# Database migrations
php artisan migrate
php artisan migrate:fresh --seed
```

## Architecture Overview

**HabitShare** is a habit-tracking PWA for educational institutions. Users have one of three roles — `admin`, `mentor`, or `student` — managed via Spatie Permission. The `/dashboard` route redirects each role to their appropriate interface.

### Three Distinct UIs

1. **Student UI** — Inertia/Vue3 SPA under `/student/*` (routes/student.php). Students log habit completions, view reflections, and track attendance.
2. **Mentor Panel** — Filament panel at `/mentor` (`app/Filament/Mentor/`). Mentors manage classrooms, assign habits, and monitor students. Also has a custom `/mentor/my-habits` page outside Filament.
3. **Admin Panel** — Filament panel at `/admin` (`app/Filament/Resources/`). Full CRUD over all entities.

### Habit Assignment Model

`Habit` is global master data. Students are linked to habits via the `habit_user` pivot table (columns: `color`, `frequency`, `is_active`). When querying a student's habits, always go through `$user->habits()` (BelongsToMany), not directly from the `habits` table.

### Key Models & Relations

- `User` — has roles via Spatie, `belongsToMany` Habits, `belongsToMany` Classrooms (as student), `belongsToMany` Classrooms as mentor, `hasOne` StudentProfile, `hasMany` Attendances
- `Habit` — belongs to `HabitCategory`; `belongsToMany` Users (students) via pivot
- `HabitLog` — daily completion record (`student_id`, `habit_id`, `log_date`, `status`)
- `Classroom` — `belongsTo` User (mentor), `belongsToMany` Users (students)
- `Attendance` — tied to a Classroom, records student presence

### Role Access Control

- `AppServiceProvider` grants admins all permissions via `Gate::before`
- Filament panels check `canAccessPanel()` on the User model
- Route files apply middleware: `auth`, `role:student` / `role:mentor`

### Vite Entry Points

Two JS entries exist: `resources/js/app.js` (main Inertia app) and `resources/js/filament-mentor-widget.js` (custom widget rendered inside the Mentor Filament panel).

### Testing

Tests use Pest with an in-memory SQLite database. The `composer test` script clears config cache before running.

### Internationalization Note

UI text is in Indonesian (e.g., "Kebiasaanku" = "My Habits"). Keep new UI strings consistent with this.
