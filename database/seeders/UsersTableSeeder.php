<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        DB::table('users')->insert([
            'user_name' => 'John Doe',
            'profile_picture' => 'abb',
            'email' => 'john@doe.com',
            'password' => Hash::make('password'),
            'personal_goal' => 'personal_goal',
            'height' => '5.5',
            'weight' => '62',
            'gender' => '1',
            'date_of_birth' => '2021-08-13',
            'goal_id'=> '0',
            'goal_description'=>'test',
            'id_proof'=>'id_proof',
            'created_at'=> '2020-10-13 08:55:42',
            'updated_at'=> '2020-10-13 08:55:42'
        ]);
    }
}
