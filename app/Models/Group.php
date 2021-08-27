<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Group extends Model
{
    use HasFactory;
    protected $fillable = [
        'id', 'group_name', 'goal','max_group_members','group_image','created_by','zip_code','active_members','last_message','status'
    ];
}
