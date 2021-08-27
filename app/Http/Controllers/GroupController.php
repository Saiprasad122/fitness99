<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\User;
use App\Models\UserGroup;
use App\Models\Group;
use App\Models\GroupMember;
use Validator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Kreait\Firebase;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;
use Kreait\Firebase\Database;

class GroupController extends Controller
{
    
    public function group_list(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required'
        ]);
        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }
                            
        $result = DB::table('group_members')
                            ->leftjoin('groups','groups.id','group_members.group_id')
                            ->select('groups.*')
                            ->where('group_members.user_id',$input['user_id'])
                            ->orderBy('updated_at', 'DESC')
                            ->where('groups.group_name', 'like', '%' . $input['search'] . '%')
                            ->get();
                            
            return response()->json([
            "result" => $result,
            "message" => 'Success',
            "status" => 1
        ]);
    }
    
    public function create_group(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'group_name' => 'required',
            'goal' => 'required',
            'max_group_members' => 'required',
            'group_image' => 'required',
            'created_by' => 'required',
            'zip_code' => 'required',
        ]);
        
        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }
        
        $group = $input;
        $group_id = Group::create($group)->id;
        
        $group_members = [];
        $group_members['user_id'] = $input['created_by'];
        $group_members['group_id'] = $group_id;
        
        $data = Group::where('id', $group_id)->first();
        //print_r($data);exit;
        $factory = (new Factory)->withServiceAccount(config_path().'/'.env('FIREBASE_FILE'));
        $database = $factory->createDatabase();
        //$database = $firebase->getDatabase();
        $members[] = (int) $input['created_by'];
        $newPost = $database
        ->getReference('groups/'.$group_id)
        ->update([
            'group_name' => $input['group_name'],
            'group_image' =>  env('IMG_URL').$data->group_image,
            'last_message' => 'null',
            'last_update'=> time(),
            'members' => $members,
            
        ]);
        
        if(GroupMember::create($group_members)){
        
        $data = GroupMember::select('group_id')->where('user_id',$input['created_by'])->pluck('group_id')->toArray();    
        $factory = (new Factory)->withServiceAccount(config_path().'/'.env('FIREBASE_FILE'));
        $database = $factory->createDatabase();
        //$database = $firebase->getDatabase();
        //$user[] = (int) $data;
        //print_r($data);exit;
        $update[$input['created_by']] = $data;
        $newPost = $database
        ->getReference('user_groups')
        ->update($update);
        
             return response()->json([
                "message" => 'Success',
                "status" => 1
            ]);
        }else{
            return response()->json([
                "message" => 'Sorry something went wrong',
                "status" => 0
            ]);
        }
    
    }
    
    public function my_groups(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required',

        ]);
        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }
                            
        $result = Group::where('created_by',$input['user_id'])->where('group_name', 'like', '%' . $input['search'] . '%')->orderBy('created_at', 'DESC')->get();
                
            return response()->json([
            "result" => $result,
            "message" => 'Success',
            "status" => 1
        ]);
    }
    
    public function image_upload(Request $request){

        $input = $request->all();
        $validator = Validator::make($input, [
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $name = time().'.'.$image->getClientOriginalExtension();
            $destinationPath = public_path('/uploads/group_images');
            $image->move($destinationPath, $name);
            return response()->json([
                "result" => 'group_images/'.$name,
                "message" => 'Success',
                "status" => 1
            ]);
            
        }
    }
    
    public function group_details(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'group_id' => 'required',

        ]);
        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }
           
        $result = DB::table('user_groups')
                            ->leftjoin('groups','groups.id','user_groups.group_id')
                            ->leftjoin('users','users.id','user_groups.user_id')
                            ->select('groups.*','users.user_name')
                            ->where('user_groups.group_id',$input['group_id'])
                            ->get();
                
            return response()->json([
            "result" => $result,
            "message" => 'Success',
            "status" => 1
        ]);
    }

    public function sendError($message) {
        $message = $message->all();
        $response['error'] = "validation_error";
        $response['message'] = implode('',$message);
        $response['status'] = "0";
        return response()->json($response, 200);
    } 
}
