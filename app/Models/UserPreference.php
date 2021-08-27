<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserPreference extends Model
{
    use HasFactory;
    protected $fillable = [
        'id', 'user_id', 'sun','sun_from_time', 'sun_to_time', 'mon', 'mon_from_time','mon_to_time', 'tue','tue_from_time','tue_to_time','wed','wed_from_time', 'wed_to_time', 'thu', 'thu_from_time','thu_to_time','fri','fri_from_time','fri_to_time','sat','sat_from_time', 'sat_to_time','created_at','updated_at','status'
    ];
}
