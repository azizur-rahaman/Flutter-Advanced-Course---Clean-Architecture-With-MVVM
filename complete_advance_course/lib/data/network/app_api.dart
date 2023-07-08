import 'package:complete_advance_course/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:complete_advance_course/app/constant.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServerClient {
  factory AppServerClient(Dio dio, {required String baseUrl}) =>
      _AppServerClient(dio);
      
@POST("/customers/login")
Future<AuthenticationResponse> login();

}

