<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Group;
use App\Models\Screen;
use App\Models\Seat;
use App\Models\Weekday;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        Group::create([
            'name' => 'user'
        ]);
        Group::create([
            'name' => 'admin'
        ]);

        for($i = 2; $i <= 7; $i++){
            Weekday::create([
                'name' => 'Thứ '.$i
            ]);
        }
        Weekday::create([
            'name' => 'Chủ nhật'
        ]);

        for($i = 1; $i <= 10; $i++){
            Screen::create([
                'name' => 'Phòng '.$i
            ]);

            for($j = 1; $j <= 50; $j++){
                Seat::create([
                    'name' => 'Ghế '.$j,
                    'screen_id' => $i,
                ]);
            }
        }
    }
}
