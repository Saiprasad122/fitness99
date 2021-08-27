<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Validator;

class ApiUserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function users($id=null)
    {
        //get all users
        return $id?User::find($id):User::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $req)
    {
        //
        $rules = array(
            "user_name" => "required",
            "email" => "required|email|regex:/^[a-zA-Z]{1}/|unique:users,email",
            "password" => "required",
        );
        $validator = Validator::make($req->all(),$rules);
        if($validator->fails()){
            return response()->json($validator->errors(),401);
        }
        else{
            $user = new User;
            $options = [
                'cost' => 12,
            ];
            $pass = password_hash($req->password, PASSWORD_DEFAULT, $options);
            $user->user_name=$req->user_name;
            $user->profile_picture=$req->profile_picture;
            $user->personal_goal=$req->personal_goal;
            $user->height=$req->height;
            $user->weight=$req->weight;
            $user->gender=$req->gender;
            $user->date_of_birth=$req->date_of_birth;
            $user->goal_id=$req->goal_id;
            $user->goal_description=$req->goal_description;
            $user->email=$req->email;
            $user->password=$pass;
            $user->id_proof=$req->id_proof;
            $result =$user->save();
            if($result){
                return [
                    "status" => 200,
                    "message"=>"success",
                ];
            }
            else{
                return response()->json([
                    "status" => 400,
                    "message"=>"Bad Request",
                ],400);
            }
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
