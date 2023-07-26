import 'package:complete_advance_course/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMOUTE,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.hand(dynamic error) {
    if (error is DioException) {
      // dio error means it's coming from response
      failure = _handleError(error);
    } else {
      // DEFAULT  error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();

      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();

      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMOUTE.getFailure();
      case DioExceptionType.badResponse:
        return DataSource.BAD_REQUEST.getFailure();
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioExceptionType.unknown:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORISED:
            return DataSource.UNAUTHORISED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      default:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
        break;
      case DataSource.FORBIDDEN:
        Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
        break;
      case DataSource.UNAUTHORISED:
        Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
        break;
      case DataSource.NOT_FOUND:
        Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
        break;
      case DataSource.INTERNAL_SERVER_ERROR:
        Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
        break;
      case DataSource.CONNECT_TIMEOUT:
        Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
        break;
      case DataSource.CANCEL:
        Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
        break;
      case DataSource.RECEIVE_TIMOUTE:
        Failure(ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
        break;
      case DataSource.SEND_TIMEOUT:
        Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
        break;
      case DataSource.CACHE_ERROR:
        Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
        break;
      case DataSource.NO_INTERNET_CONNECTION:
        Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
        break;
      case DataSource.DEFAULT:
        Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
        break;
      default:
        Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
        break;
    }
    ;
  }
}

class ResponseCode {
// API status codes
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // succcess with no content
  static const int BAD_REQUEST = 400; // failure, api rejected the request
  static const int FORBIDDEN = 403; // failure, api rejected the request
  static const int UNAUTHORISED = 401; // failure, user is not authorized
  static const int NOT_FOUND = 404; // failure, api url not correct or not found
  static const int INTERNAL_SERVER_ERROR =
      500; // failure, crashed happened in th server side

// local status codes
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
// API status codes
  static const String SUCCESS = "sccess"; // success with data
  static const String NO_CONTENT =
      "success with no content"; // succcess with no content
  static const String BAD_REQUEST =
      "Bad request, try again later"; // failure, api rejected the request
  static const String FORBIDDEN =
      "forbidden request, try again later"; // failure, api rejected the request
  static const String UNAUTHORISED =
      "user is unauthorized, try again later"; // failure, user is not authorized
  static const String NOT_FOUND =
      "Url is not found, try gain later"; // failure, api url not correct or not found
  static const String INTERNAL_SERVER_ERROR =
      "something went wrong, try gain later"; // failure, crashed happened in th server side

// local status codes
  static const String DEFAULT = "something went wrong, try gain later";
  static const String CONNECT_TIMEOUT = "timout error, try gain later";
  static const String CANCEL = "request was cancelled, try gain later";
  static const String RECEIVE_TIMEOUT = "time out error, try gain later";
  static const String SEND_TIMEOUT = "timeout error, try gain later";
  static const String CACHE_ERROR = "Cache error, try gain later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
