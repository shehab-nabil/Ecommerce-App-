import 'package:dartz/dartz.dart';
import 'package:tut/data/data_source/remote_data_source.dart';
import 'package:tut/data/mapper/mapper.dart';
import 'package:tut/data/networks/error_handler.dart';

import 'package:tut/data/networks/failure.dart';
import 'package:tut/data/networks/network_info.dart';

import 'package:tut/data/networks/requests.dart';

import 'package:tut/domain/models/models.dart';

import '../../domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequests loginRequests) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.login(loginRequests);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.defaultCode));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
