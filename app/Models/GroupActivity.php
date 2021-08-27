<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupActivity extends Model
{
    use HasFactory;
    protected $fillable = [
        'id','activity_title','activity_description','activity_location','additional_notes','day','from_time','to_time','status', 'created_at', 'updateded_at',
    ];
}
