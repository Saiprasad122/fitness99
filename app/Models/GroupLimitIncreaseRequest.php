<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupLimitIncreaseRequest extends Model
{
    use HasFactory;
    protected $fillable = [
        'id', 'group_id', 'requested_by','comment','requesting_count','existing_count','created_at','updated_at','status'
    ];
}
