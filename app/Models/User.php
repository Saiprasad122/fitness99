<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;
class User extends Model
{
    use HasFactory,HasApiTokens;
    protected $fillable = [
        'id', 'user_name', 'phone_number','email','password','profile_picture'
    ];
}
