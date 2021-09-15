import 'package:dio/dio.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_model.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_request.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'http://fitness.rithlaundry.com/api/user/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/login')
  Future<LoginResponse> getLoginResponse(@Body() LoginRequest loginRequest);

  // factory ApiService.create({required Dio dio}) {
  //   final url = kDebugMode ? APP_ENV['BASE_URL_DEV'] : APP_ENV['BASE_URL'];
  //   dio
  //     ..options = BaseOptions(
  //         receiveTimeout: 20000, connectTimeout: 20000, baseUrl: url)
  //     ..interceptors.add(PrettyDioLogger(
  //       requestBody: true,
  //       compact: true,
  //     ));
  //   return ApiClient(dio);
  // }

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
