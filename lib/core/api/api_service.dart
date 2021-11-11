import 'package:dio/dio.dart';
import 'package:fitness_99/models/baseResponse/base.response.dart';
import 'package:fitness_99/models/cando_cannotdo_goal/cando_cannotdo_goal.response.dart';
import 'package:fitness_99/models/display_group_reponse.dart';
import 'package:fitness_99/models/join_group_reponse.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_request.dart';
import 'package:fitness_99/models/signUpResponseRequest/sign_up_reponse.dart';
import 'package:fitness_99/models/signUpResponseRequest/sign_up_request.dart';
import 'package:fitness_99/models/updateProfilePicture/update_profile_picture_request.dart';
import 'package:fitness_99/models/updateProfilePicture/update_profile_picture_response.dart';
import 'package:fitness_99/models/updateProfileResponseRequest/update_profile_request.dart';
import 'package:fitness_99/utils/api_urls.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiUrls.BASE_TEST_URL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // ----------------------- ************************ ------------------------------ //
  //                                GET REQUEST                                      //
  // ----------------------- ************************ ------------------------------ //
  @GET(ApiUrls.GET_CAN_DO)
  Future<BaseResponse<List<GetCanDoCannotDoGoals>>> getCanDos(
      {@Path('id') required int userId});
  @GET(ApiUrls.GET_CANNOT_DO)
  Future<BaseResponse<List<GetCanDoCannotDoGoals>>> getCannotDos(
      {@Path('id') required int userId});
  @GET(ApiUrls.GET_GOAL)
  Future<BaseResponse<List<GetCanDoCannotDoGoals>>> getGoals(
      {@Path('id') required int userId});
  @GET(ApiUrls.DISPLAY_MY_GROUP)
  Future<BaseResponse<List<DisplayGroups>>> getMyGroups(
      {@Path('id') required int userId});
  @GET(ApiUrls.DISPLAY_GROUP)
  Future<BaseResponse<List<DisplayGroups>>> getGroups(
      {@Path('id') required int userId});
  @GET(ApiUrls.DISPLAY_ALL_GROUPS)
  Future<BaseResponse<List<DisplayGroups>>> getAllGroups();
  @GET(ApiUrls.JOIN_GROUP)
  Future<BaseResponse<JoinGroupResponse>> joinGroup(
      {@Path('id') required int userID,
      @Path('group_id') required int group_id});

  // ----------------------- ************************ ------------------------------ //
  //                               POST REQUEST                                      //
  // ----------------------- ************************ ------------------------------ //
  @POST(ApiUrls.lOGIN)
  Future<LoginResponse> getLoginResponse(@Body() LoginRequest loginRequest);
  @POST(ApiUrls.REGISTER)
  Future<SignUpResponse> getSignUpResponse(@Body() SignUpRequest signUpRequest);
  @POST(ApiUrls.UPDATE_USER)
  Future<UpdateProfilePictureResponse> getUpdateProfileReponse(
      {@Body() required UpdateProfileRequest updateProfileRequest,
      @Path('id') required int userId});
  @POST(ApiUrls.PROFILE_UPDATE)
  Future<UpdateProfilePictureResponse> geUpdateProfilePic(
      {@Body() required UpdateProfilePictureRequest updateProfilePictureRequest,
      @Path('id') required int userId});
  @POST(ApiUrls.CREATE_CAN_DO)
  Future<BaseResponse> createCanDo(
      {@Body() required Map<String, dynamic> createCanDoRequest,
      @Path('id') required int userId});
  @POST(ApiUrls.CREATE_CANNOT_DO)
  Future<BaseResponse> createCannotDo(
      {@Body() required Map<String, dynamic> createCannotDoRequest,
      @Path('id') required int userId});
  @POST(ApiUrls.CREATE_GOAL)
  Future<BaseResponse> createGoal(
      {@Body() required Map<String, dynamic> createGoalRequest,
      @Path('id') required int userId});

  // ----------------------- ************************ ------------------------------ //
  //                              DELETE REQUEST                                     //
  // ----------------------- ************************ ------------------------------ //
  @DELETE(ApiUrls.DELETE_CAN_DO)
  Future<BaseResponse> deleteCanDo({@Path('id') required int canDoId});
  @DELETE(ApiUrls.DELETE_CANNOT_DO)
  Future<BaseResponse> deleteCannotDo({@Path('id') required int cannotDoId});
  @DELETE(ApiUrls.DELETE_GOAL)
  Future<BaseResponse> deleteGoal({@Path('id') required int goalId});

  factory ApiService.create() {
    final client =
        Dio(BaseOptions(connectTimeout: 20000, receiveTimeout: 20000))
          ..interceptors.add(PrettyDioLogger(
            requestBody: true,
            compact: true,
          ));
    return ApiService(client);
  }
}
