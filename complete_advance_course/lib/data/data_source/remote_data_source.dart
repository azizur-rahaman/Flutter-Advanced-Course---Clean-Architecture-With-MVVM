import 'package:complete_advance_course/data/request/request.dart';
import 'package:complete_advance_course/data/responses/responses.dart';
import 'package:complete_advance_course/data/network/app_api.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient? _appServiceClient;

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient!.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }
}
