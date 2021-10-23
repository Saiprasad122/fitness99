import 'package:dio/dio.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_request.dart';
import 'package:fitness_99/models/signUpResponseRequest/sign_up_reponse.dart';
import 'package:fitness_99/models/signUpResponseRequest/sign_up_request.dart';
import 'package:fitness_99/models/updateProfilePicture/update_profile_picture_request.dart';
import 'package:fitness_99/models/updateProfilePicture/update_profile_picture_response.dart';
import 'package:fitness_99/models/updateProfileResponseRequest/updateProfileResponse.dart';
import 'package:fitness_99/models/updateProfileResponseRequest/update_profile_request.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://dev.99fitnessfriends.com/api')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/login')
  Future<LoginResponse> getLoginResponse(@Body() LoginRequest loginRequest);
  @POST('/register')
  Future<SignUpResponse> getSignUpResponse(@Body() SignUpRequest signUpRequest);
  @POST('/updateUser/{id}')
  Future<UpdateProfilePictureResponse> getUpdateProfileReponse(
      @Body() UpdateProfileRequest updateProfileRequest);
  @POST('/profile_picture')
  Future<UpdateProfilePictureResponse> geUpdateProfilePic(
      @Body() UpdateProfilePictureRequest updateProfilePictureRequest);

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
