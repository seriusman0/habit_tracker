<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo json_encode(App\Models\Habit::get(['id', 'title', 'category_id', 'student_id', 'created_by_user_id'])->toArray(), JSON_PRETTY_PRINT);
