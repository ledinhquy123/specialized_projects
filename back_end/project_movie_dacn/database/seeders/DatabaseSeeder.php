<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Group;
use App\Models\Screen;
use App\Models\Seat;
use App\Models\Transaction;
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
        // Groups
        Group::create([
            'name' => 'user'
        ]);
        Group::create([
            'name' => 'admin'
        ]);

        // Weekdays
        for($i = 2; $i <= 7; $i++){
            Weekday::create([
                'name' => 'Thứ '.$i
            ]);
        }
        Weekday::create([
            'name' => 'Chủ nhật'
        ]);

        // Screens and seats
        for($i = 1; $i <= 10; $i++){
            Screen::create([
                'name' => 'Phòng '.$i
            ]);

            for($j = 1; $j <= 50; $j++){
                Seat::create([
                    'name' => chr(64 + $i) . $j,
                    'screen_id' => $i,
                ]);
            }
        }

        // Transactions_type
        Transaction::create([
            'name' => 'VN Pay'
        ]);
        
        Transaction::create([
            'name' => 'Momo'
        ]);
        Transaction::create([
            'name' => 'Zalo Pay'
        ]);
    }
}
