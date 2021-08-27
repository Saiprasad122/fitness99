<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\User;
use App\Models\Interest;
use App\Models\UserInterest;
use App\Models\UserGroup;
use App\Models\UserPreference;
use App\Models\GroupInvitation;
use App\Models\Group;
use App\Models\GroupMember;
use App\Models\GroupActivity;
use App\Models\Preference;
use App\Models\Product;
use App\Models\Category;
use App\Models\GroupCategory;
use App\Models\Subscription;
use App\Models\UserActivity;
use App\Models\UserCategory;
use App\Models\Day;
use App\Models\GroupLimitIncreaseRequest;
use Validator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Kreait\Firebase;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;
use Kreait\Firebase\Database;

class UserController extends Controller
{

    function index(Request $request)
    {
        $user= User::where('email', $request->email)->first();
        // print_r($data);
            if (!$user || !Hash::check($request->password, $user->password)) {
                return response([
                    'message' => ['These credentials do not match our records.']
                ], 404);
            }

             $token = $user->createToken('my-app-token')->plainTextToken;

            $response = [
                'user' => $user,
                'token' => $token
            ];

             return response($response, 201);
    }

    public function register(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'user_name' => 'required',
            'email' => 'required|email|regex:/^[a-zA-Z]{1}/|unique:users,email',
            'password' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $options = [
            'cost' => 12,
        ];
        $input['password'] = password_hash($input["password"], PASSWORD_DEFAULT, $options);
        $input['status'] = 1;

        $user = User::create($input);

        if (is_object($user)) {
            return response()->json([
                "result" => $user,
                "message" => 'Registered Successfully',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong !',
                "status" => 0
            ]);
        }

    }

    public function user_get_preferences(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $data = UserPreference::where('user_id',$input['user_id'])->first();
        if(is_object($data)){
           if($data->sun_from_time != '00:00:00'){
             $data->sun_from_time = date('h:i A',strtotime($data->sun_from_time));
           }

           if($data->sun_to_time != '00:00:00'){
             $data->sun_to_time = date('h:i A',strtotime($data->sun_to_time));
           }

           if($data->mon_from_time != '00:00:00'){
             $data->mon_from_time = date('h:i A',strtotime($data->mon_from_time));
           }

           if($data->mon_to_time != '00:00:00'){
             $data->mon_to_time = date('h:i A',strtotime($data->mon_to_time));
           }

           if($data->tue_from_time != '00:00:00'){
             $data->tue_from_time = date('h:i A',strtotime($data->tue_from_time));
           }

           if($data->tue_to_time != '00:00:00'){
             $data->tue_to_time = date('h:i A',strtotime($data->tue_to_time));
           }

           if($data->wed_from_time != '00:00:00'){
             $data->wed_from_time = date('h:i A',strtotime($data->wed_from_time));
           }

           if($data->wed_to_time != '00:00:00'){
             $data->wed_to_time = date('h:i A',strtotime($data->wed_to_time));
           }

           if($data->thu_from_time != '00:00:00'){
             $data->thu_from_time = date('h:i A',strtotime($data->thu_from_time));
           }

           if($data->thu_to_time != '00:00:00'){
             $data->thu_to_time = date('h:i A',strtotime($data->thu_to_time));
           }

           if($data->fri_from_time != '00:00:00'){
             $data->fri_from_time = date('h:i A',strtotime($data->fri_from_time));
           }

           if($data->fri_to_time != '00:00:00'){
             $data->fri_to_time = date('h:i A',strtotime($data->fri_to_time));
           }

           if($data->sat_from_time != '00:00:00'){
             $data->sat_from_time = date('h:i A',strtotime($data->sat_from_time));
           }

           if($data->sat_to_time != '00:00:00'){
             $data->sat_to_time = date('h:i A',strtotime($data->sat_to_time));
           }

            return response()->json([
                "result" => $data,
                "message" => 'Success',
                "status" => 1
            ]);

        }else{
            return response()->json([
                "message" => 'Sorry, no data found',
                "status" => 0
            ]);
        }
    }

    public function profile_settings(Request $request)
    {
        $input = $request->all();
        $id = $input['id'];
        $validator = Validator::make($input, [
            'height' => 'required',
            'weight' => 'required',
            'gender' => 'required',
            'date_of_birth' => 'required',
            'goal_id' => 'required',
            'goal_description' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        if (User::where('id',$id)->update($input)) {
            $user = User::where('id',$id)->update([ 'profile_status' => 1]);
            return response()->json([
                "result" => User::select('id', 'personal_goal','height','weight','gender','date_of_birth', 'gender','goal_id', 'goal_description')->where('id',$id)->first(),
                "message" => 'Success',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong...',
                "status" => 0
            ]);
        }

    }

    public function profile_update(Request $request)
    {
        $input = $request->all();
        $id = $input['id'];
        $validator = Validator::make($input, [
            'user_name' => 'required',
            'phone_number' => 'required|numeric|unique:users,id,'.$id,
            'email' => 'required|email|unique:users,id,'.$id,
            'profile_picture' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }
        if($request->password){
            $options = [
                'cost' => 12,
            ];
            $input['password'] = password_hash($input["password"], PASSWORD_DEFAULT, $options);
            $input['status'] = 1;
        }else{
            unset($input['password']);
        }

        if (User::where('id',$id)->update($input)) {
            return response()->json([
                "result" => User::where('id',$id)->first(),
                "message" => 'Success',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong...',
                "status" => 0
            ]);
        }

    }

    public function login(Request $request){

        $input = $request->all();
        $validator = Validator::make($input, [
            'email' => 'required',
            'password' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $credentials = request(['email', 'password']);
        $user = User::where('email',$credentials['email'])->first();

        if (!($user)) {
            return response()->json([
                "message" => 'Invalid email or password',
                "status" => 0
            ]);
        }

        if (Hash::check($credentials['password'], $user->password)) {
            if($user->status == 1){
                return response()->json([
                    "result" => $user,
                    "message" => 'Success',
                    "status" => 1
                ]);
            }else{
                return response()->json([
                    "message" => 'Your account has been blocked',
                    "status" => 0
                ]);
            }
        }else{
            return response()->json([
                "message" => 'Invalid email or password',
                "status" => 0
            ]);
        }

    }

    public function profile_picture(Request $request){

        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required',
            'profile_picture' => 'required|image|mimes:jpeg,png,jpg,gif,svg'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        if ($request->hasFile('profile_picture')) {
            $image = $request->file('profile_picture');
            $name = time().'.'.$image->getClientOriginalExtension();
            $destinationPath = public_path('/uploads/images');
            $image->move($destinationPath, $name);
            if(User::where('id',$input['user_id'])->update([ 'profile_picture' => 'images/'.$name ])){
                return response()->json([
                    "result" => User::select('id', 'user_name','phone_number','email','profile_picture','status')->where('id',$input['user_id'])->first(),
                    "message" => 'Success',
                    "status" => 1
                ]);
            }else{
                return response()->json([
                    "message" => 'Sorry something went wrong...',
                    "status" => 0
                ]);
            }
        }

    }

    public function forgot_password(Request $request){

        $input = $request->all();
        $validator = Validator::make($input, [
            'email' => 'required|email|regex:/^[a-zA-Z]{1}/',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $user = User::where('email',$input['email'])->first();
        if(is_object($user)){
            $otp = rand(1000,9999);
            User::where('id',$user->id)->update(['otp'=> $otp ]);
            $mail_header = array("otp" => $otp);
            $this->send_mail($mail_header,'Reset Password',$input['email']);
            return response()->json([
                "result" => User::select('id', 'otp')->where('id',$user->id)->first(),
                "message" => 'Success',
                "status" => 1
            ]);
        }else{
            return response()->json([
                "message" => 'Invalid email address',
                "status" => 0
            ]);
        }

    }

    public function reset_password(Request $request){

        $input = $request->all();
        $validator = Validator::make($input, [
            'id' => 'required',
            'password' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $options = [
            'cost' => 12,
        ];
        $input['password'] = password_hash($input["password"], PASSWORD_DEFAULT, $options);

        if(User::where('id',$input['id'])->update($input)){
            return response()->json([
                "message" => 'Success',
                "status" => 1
            ]);
        }else{
            return response()->json([
                "message" => 'Invalid email address',
                "status" => 0
            ]);
        }
    }

    public function get_profile(Request $request){

        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $data['user'] = User::where('id',$input['user_id'])->first();

        $data['group'] = UserGroup::where('id',$input['user_id'])->count();
        $data['invite'] = GroupInvitation::where('to_user_id',$input['user_id'])->where('status',1)->count();
        if($data){
            return response()->json([
                "result" => $data,
                "message" => 'Success',
                "status" => 1
            ]);
        }
        else{
            return response()->json([
                "message" => 'Something went wrong',
                "status" => 0
            ]);
        }
    }

    public function cando_update(Request $request)
    {
        $input = $request->all();
        $id = $input['id'];
        $validator = Validator::make($input, [
            'can_do' => 'required',
            'cannot_do' => 'required'

        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        if (User::where('id',$id)->update($input)) {
            return response()->json([
                "result" => User::where('id',$id)->first(),
                "message" => 'Success',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong...',
                "status" => 0
            ]);
        }

    }

     public function goal_update(Request $request)
    {
        $input = $request->all();
        $id = $input['id'];
        $validator = Validator::make($input, [
            'personal_goal' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        if (User::where('id',$id)->update($input)) {
            return response()->json([
                "result" => User::where('id',$id)->first(),
                "message" => 'Success',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong...',
                "status" => 0
            ]);
        }

    }


    public function preference_list()
    {
        $data = Preference::where('status',1)->get();

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function preference_update(Request $request)
    {
        $input = $request->all();
        $id = $input['id'];
        $validator = Validator::make($input, [
            'preference_id' => 'required'

        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        if (UserPreference::where('id',$id)->update($input)) {
            return response()->json([
                "result" => UserPreference::where('id',$id)->first(),
                "message" => 'Success',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong...',
                "status" => 0
            ]);
        }

    }

    public function interest_list()
    {
        $data = Interest::where('status',1)->get();

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function user_interest(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required'

        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }
        $data['interest'] = Interest::where('status',1)->get();
        $data['user_interest'] = UserInterest::where('status',1)->where('user_id',$input['user_id'])->get();

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function product_list()
    {
        $data = Product::where('status',1)->get();

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function product_detail(Request $request){

        $input = $request->all();
        $validator = Validator::make($input, [
            'product_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $data = Product::where('id',$input['product_id'])->first();

        if($data){
            return response()->json([
                "result" => $data,
                "message" => 'Success',
                "status" => 1
            ]);
        }
        else{
            return response()->json([
                "message" => 'Something went wrong',
                "status" => 0
            ]);
        }
    }

    public function subscription(Request $request){

        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $data = DB::table('subscriptions')
            ->leftjoin('users', 'subscriptions.user_id', '=', 'users.id')
            ->leftjoin('packages', 'subscriptions.package_id', '=', 'packages.id')
            ->leftjoin('payment_modes', 'subscriptions.payment_mode', '=', 'payment_modes.id')
            ->select('subscriptions.*', 'users.user_name', 'packages.package_name',  'payment_modes.payment_name', 'subscriptions.id')
            ->where('subscriptions.user_id',$input['user_id'])->first();

        if($data){
            return response()->json([
                "result" => $data,
                "message" => 'Success',
                "status" => 1
            ]);
        }
        else{
            return response()->json([
                "message" => 'Something went wrong',
                "status" => 0
            ]);
        }
    }

    public function category_list()
    {
        $data = Category::select('id','category_name as name')->where('status',1)->get()->toArray();

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function group_category_list(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'group_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $data = GroupCategory::select('category_id')->where('group_id',$input['group_id'])->pluck('category_id');

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function user_category_list(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        /*$data = DB::table('user_categories')
            ->leftjoin('users', 'user_categories.user_id', '=', 'users.id')
            ->leftjoin('categories', 'user_categories.category_id', '=', 'categories.id')
            ->select('user_categories.*', 'users.user_name', 'categories.category_name', 'user_categories.id')*/
        $data = UserCategory::select('category_id')->where('user_id',$input['user_id'])->pluck('category_id');

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function update_group_categories(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'group_id' => 'required',
            'category_id' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $categories = explode(",",$input['category_id']);
        GroupCategory::where('group_id',$input['group_id'])->delete();
        foreach($categories as $key => $value){
            $data['group_id'] = $input['group_id'];
            $data['category_id'] = $value;
            GroupCategory::create($data);
        }

        return response()->json([
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function update_user_categories(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required',
            'category_id' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $categories = explode(",",$input['category_id']);
        UserCategory::where('user_id',$input['user_id'])->delete();
        foreach($categories as $key => $value){
            $data['user_id'] = $input['user_id'];
            $data['category_id'] = $value;
            UserCategory::create($data);
        }

        return response()->json([
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function update_user_preferences(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'user_id' => 'required',

        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $input['sun_from_time'] = date('H:i:s',strtotime($input['sun_from_time']));
        $input['sun_to_time'] = date('H:i:s',strtotime($input['sun_to_time']));
        $input['mon_from_time'] = date('H:i:s',strtotime($input['mon_from_time']));
        $input['mon_to_time'] = date('H:i:s',strtotime($input['mon_to_time']));
        $input['tue_from_time'] = date('H:i:s',strtotime($input['tue_from_time']));
        $input['tue_to_time'] = date('H:i:s',strtotime($input['tue_to_time']));
        $input['wed_from_time'] = date('H:i:s',strtotime($input['wed_from_time']));
        $input['wed_to_time'] = date('H:i:s',strtotime($input['wed_to_time']));
        $input['thu_from_time'] = date('H:i:s',strtotime($input['thu_from_time']));
        $input['thu_to_time'] = date('H:i:s',strtotime($input['thu_to_time']));
        $input['fri_from_time'] = date('H:i:s',strtotime($input['fri_from_time']));
        $input['fri_to_time'] = date('H:i:s',strtotime($input['fri_to_time']));
        $input['sat_from_time'] = date('H:i:s',strtotime($input['sat_from_time']));
        $input['sat_to_time'] = date('H:i:s',strtotime($input['sat_to_time']));

        UserPreference::where('user_id',$input['user_id'])->delete();
        UserPreference::create($input);
        return response()->json([
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function group_activity(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'activity_title' => 'required',
            'activity_description' => 'required',
            'activity_location' => 'required',
            'day' => 'required',
            'from_time' => 'required',
            'to_time' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $input['status'] = 1;

        $activity = GroupActivity::create($input);

        if (is_object($activity)) {
            return response()->json([
                "result" => $activity,
                "message" => 'Registered Successfully',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong !',
                "status" => 0
            ]);
        }

    }

    public function day_list()
    {
        $data = Day::where('status',1)->get();

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function group_limit_request(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'group_id' => 'required',
            'requesting_count' => 'required',
            'comment' => 'required',
            'requested_by' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $input['status'] = 1;
        $input['existing_count'] = Group::where('id', $input['group_id'])->value('max_group_members');
        //print_r($input['existing_count']);exit;
        $request = GroupLimitIncreaseRequest::create($input);

        if (is_object($request)) {
            return response()->json([
                "result" => $request,
                "message" => 'Successfully Sent',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong !',
                "status" => 0
            ]);
        }

    }

    public function group_limit_request_list(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'group_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $data = GroupLimitIncreaseRequest::where('group_id',$input['group_id'])->orderBy('id', 'DESC')->get();

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function invitation_list(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'to_user_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $data = DB::table('group_invitations')
            ->leftjoin('users', 'group_invitations.from_user_id', '=', 'users.id')
            ->leftjoin('groups', 'group_invitations.group_id', '=', 'groups.id')
            ->select('group_invitations.*', 'users.user_name', 'users.profile_picture', 'groups.group_name', 'group_invitations.id')
            ->where('to_user_id',$input['to_user_id'])
            ->where('group_invitations.status',1)
            ->orderBy('id', 'DESC')->get();

        return response()->json([
            "result" => $data,
            "count" => count($data),
            "message" => 'Success',
            "status" => 1
        ]);

    }

    public function invitation_accept(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'invite_id' => 'required',
            'status' => 'required'
        ]);
        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        GroupInvitation::where('id',$input['invite_id'])->update([ 'status' => $input['status']]);
        $invite = GroupInvitation::where('id',$input['invite_id'])->first();
        if($input['status'] == 2){
            $data['user_id'] = $invite->to_user_id;
            $data['group_id'] = $invite->group_id;
            $data['status'] = 1;
            GroupMember::create($data);

        $data = GroupMember::select('group_id')->where('user_id',$data['user_id'])->pluck('group_id')->toArray();
        $factory = (new Factory)->withServiceAccount(config_path().'/'.env('FIREBASE_FILE'));
        $database = $factory->createDatabase();
        $update[$invite->to_user_id] = $data;
        $newPost = $database
        ->getReference('user_groups')
        ->update($update);
        }
        return response()->json([
            "message" => 'Success',
            "status" => 1
        ]);
    }

    public function invitation_request(Request $request)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'group_id' => 'required',
            'from_user_id' => 'required',
            'to_user_id' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $input['status'] = 1;
        $input['invite_message'] = "Dear friend, I send this invitation for you to join our fitness group which organizes fitness activities. I would be happy with your participation in the events.";
        $invite = GroupInvitation::create($input);

        $data = DB::table('group_invitations')
            ->leftjoin('users', 'group_invitations.from_user_id', '=', 'users.id')
            ->leftjoin('groups', 'group_invitations.group_id', '=', 'groups.id')
            ->select('group_invitations.*', 'users.user_name', 'groups.group_name')
            ->where('group_invitations.id',$invite->id)->first();

        if (is_object($data)) {
            return response()->json([
                "result" => $data,
                "message" => 'Successfully Sent',
                "status" => 1
            ]);
        } else {
            return response()->json([
                "message" => 'Sorry, something went wrong !',
                "status" => 0
            ]);
        }

    }

    public function find_members(Request $request){
        $input = $request->all();
        $validator = Validator::make($input, [
            'group_id' => 'required'
        ]);

        if ($validator->fails()) {
            return $this->sendError($validator->errors());
        }

        $created_by = Group::where('id',$input['group_id'])->value('created_by');
        $data = [];
        $users = DB::table('groups')
                      ->join('group_categories','group_categories.group_id','=', 'groups.id')
                      ->join('user_categories','user_categories.category_id','=', 'group_categories.category_id')
                      ->select('user_categories.user_id')
                      ->where('groups.id',$input['group_id'])
                      ->distinct()
                      ->get()
                      ->toArray();

       foreach($users as $key => $value){
           $count = GroupMember::where('group_id',$input['group_id'])->where('user_id',$value->user_id)->count();
           if($created_by != $value->user_id && $count == 0){
               $data[] = User::where('id',$value->user_id)->first();
           }
       }

        return response()->json([
                "result" => $data,
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
