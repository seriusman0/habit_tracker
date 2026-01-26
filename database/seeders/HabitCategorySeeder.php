<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\HabitCategory;

class HabitCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $categories = [
            'Bangun',
            'Ibadah',
            'Olahraga',
            'Makan',
            'Belajar',
            'Bermasyarakat',
            'Tidur',
        ];

        foreach ($categories as $category) {
            HabitCategory::firstOrCreate(['name' => $category]);
        }
    }
}
