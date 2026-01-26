<?php

namespace App\Http\Controllers\Mentor;

use App\Http\Controllers\Controller;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index()
    {
        return Inertia::render('Mentor/Dashboard');
    }
}
