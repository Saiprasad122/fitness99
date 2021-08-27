<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupCategory extends Model
{
    use HasFactory;
    protected $fillable = [
        'id', 'group_id', 'category_id','created_at','updated_at'
    ];
}
