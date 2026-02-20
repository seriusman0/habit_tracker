<?php

namespace Database\Seeders;

use App\Models\GeneticType;
use Illuminate\Database\Seeder;

class GeneticTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $types = [
            [
                'name' => 'Sensing',
                'description' => 'Focus on sensory details and concrete reality.',
            ],
            [
                'name' => 'Thinking',
                'description' => 'Analytical and logical decision making.',
            ],
            [
                'name' => 'Intuiting',
                'description' => 'Focus on possibilities, patterns, and future implications.',
            ],
            [
                'name' => 'Feeling',
                'description' => 'Decision making based on values and harmony.',
            ],
            [
                'name' => 'Instinct',
                'description' => 'Spontaneous and gut-driven reactions.',
            ],
        ];

        foreach ($types as $type) {
            GeneticType::firstOrCreate(
                ['name' => $type['name']],
                ['description' => $type['description']]
            );
        }
    }
}
