import 'package:complete_advance_course/data/request/request.dart';
import 'package:complete_advance_course/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:complete_advance_course/app/constant.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {required String baseUrl}) =>
      _AppServiceClient(dio);

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );
}
