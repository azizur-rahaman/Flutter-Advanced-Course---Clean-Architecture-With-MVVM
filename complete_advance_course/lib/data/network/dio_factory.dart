import 'package:complete_advance_course/app/app_prefs.dart';
import 'package:complete_advance_course/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accpet';
const String AUTHORIZATION = 'autorization';
const String DEFAULT_LANGUAGE = 'language';

class DioFactory {
  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {

    Dio dio = Dio();
    Duration _timeOutDuration = const Duration(minutes: 1);
    String language = await _appPreferences.getAppLanguage();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: language, // todo get language from apporefs
    };

    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: _timeOutDuration,
        receiveTimeout: _timeOutDuration,
        headers: headers);

    if (kReleaseMode) {
      debugPrint("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
