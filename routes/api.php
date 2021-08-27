<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\dummyApi;
use App\Http\Controllers\UserController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware' => 'auth:sanctum'], function(){
    //All secure URL's
    Route::get("users/{id?}",[dummyApi::class,'getUser']);
    Route::post("add_user",[dummyApi::class,'add_user']);
    Route::put("update_user/&id={id}",[dummyApi::class,'update_user']);
    Route::delete("delete_user/&id={id}",[dummyApi::class,'delete_user']);
    });

Route::post("login",[UserController::class,'index']);


Route::group(['namespace' => 'App\Http\Controllers'], function(){
Route::post('user/register','UserController@register');
Route::post('user/login','UserController@login');
Route::post('user/profile_update', 'UserController@profile_update');
Route::post('user/profile_picture', 'UserController@profile_picture');
Route::post('user/forgot_password', 'UserController@forgot_password');
Route::post('user/reset_password', 'UserController@reset_password');
Route::post('user/profile_settings', 'UserController@profile_settings');
Route::get('app_setting', 'AppSettingController@index');
Route::post('user/group_list', 'GroupController@group_list');
Route::post('user/my_groups', 'GroupController@my_groups');
Route::post('user/image_upload', 'GroupController@image_upload');
Route::post('user/create_group', 'GroupController@create_group');
Route::post('user/get_profile', 'UserController@get_profile');
Route::post('user/cando_update', 'UserController@cando_update');
Route::get('user/preference_list', 'UserController@preference_list');
Route::post('user/preference_update', 'UserController@preference_update');
Route::get('user/interest_list', 'UserController@interest_list');
Route::post('user/interest', 'UserController@user_interest');
Route::get('user/faq', 'FaqController@faq');
Route::get('user/privacy_policy', 'PrivacyPolicyController@privacy_policy');
Route::post('user/goal_update', 'UserController@goal_update');
Route::get('user/product_list', 'UserController@product_list');
Route::post('user/product_detail', 'UserController@product_detail');
Route::post('user/subscription', 'UserController@subscription');
Route::post('user/group_details', 'GroupController@group_details');
Route::get('user/category_list', 'UserController@category_list');
Route::post('user/group_category_list', 'UserController@group_category_list');
Route::post('user/user_category_list', 'UserController@user_category_list');
Route::post('user/group_activity', 'UserController@group_activity');
Route::post('user/update_group_categories', 'UserController@update_group_categories');
Route::post('user/update_user_categories', 'UserController@update_user_categories');
Route::get('user/day_list', 'UserController@day_list');
Route::post('user/user_get_preferences', 'UserController@user_get_preferences');
Route::post('user/update_user_preferences', 'UserController@update_user_preferences');
Route::post('user/group_limit_request', 'UserController@group_limit_request');
Route::post('user/group_limit_request_list', 'UserController@group_limit_request_list');
Route::post('user/invitation_list', 'UserController@invitation_list');
Route::post('user/invitation_accept', 'UserController@invitation_accept');
Route::post('user/invitation_request', 'UserController@invitation_request');
Route::post('user/find_members', 'UserController@find_members');
});
