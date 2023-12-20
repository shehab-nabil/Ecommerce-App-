import 'package:dartz/dartz.dart';
import 'package:tut/data/data_source/remote_data_source.dart';
import 'package:tut/data/mapper/mapper.dart';

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
      final response = await _remoteDataSource.login(loginRequests);
      if (response.status == 0) {
        return Right(response.toDomain());
      } else {
        // failure --return business error
        // return either left
        return Left(Failure(409, response.message ?? 'business error message'));
      }
    } else {
      // return internet connection error
      // return either left
      return Left(Failure(409, 'check ur internet connection'));
    }
  }
}
