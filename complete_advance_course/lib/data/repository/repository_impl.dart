import 'package:complete_advance_course/data/data_source/remote_data_source.dart';
import 'package:complete_advance_course/data/mapper/mapper.dart';
import 'package:complete_advance_course/data/network/error_handler.dart';
import 'package:complete_advance_course/data/network/failure.dart';
import 'package:complete_advance_course/data/network/network_info.dart';
import 'package:complete_advance_course/data/request/request.dart';
import 'package:complete_advance_course/domain/model/model.dart';
import 'package:complete_advance_course/domain/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // it's safe to call api

      try {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //return data (success);
          //return right

          return Right(response.toDomain());
        } else {
          // return business login
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.hand(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
