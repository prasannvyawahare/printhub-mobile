import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/auth/user_request.dart';
import 'package:flutter_application_1/model/auth/user_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "http://192.168.1.9:3000/api/v1/")
abstract class ApiClient {
 factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
   // @POST("user/verify-and-save")
   // Future<UserResponse> saveUser(@Body() UserRequest user);
}
