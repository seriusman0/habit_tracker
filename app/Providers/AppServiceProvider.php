<?php

namespace App\Providers;

use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(\Filament\Http\Responses\Auth\Contracts\LogoutResponse::class, \App\Http\Responses\LogoutResponse::class);
        $this->app->register(SharpServiceProvider::class);
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Vite::prefetch(concurrency: 3);

        // Explicitly register the policy
        \Illuminate\Support\Facades\Gate::policy(\App\Models\Classroom::class, \App\Policies\ClassroomPolicy::class);

        // Bypass for admin
        \Illuminate\Support\Facades\Gate::before(function ($user, $ability) {
            return $user->hasRole('admin') ? true : null;
        });
    }
}
