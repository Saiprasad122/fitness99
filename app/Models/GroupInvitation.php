<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupInvitation extends Model
{
    use HasFactory;
    protected $fillable = [
        'id', 'group_id', 'from_user_id', 'to_user_id','invite_message','status','created_at','updated_at'
    ];
}
