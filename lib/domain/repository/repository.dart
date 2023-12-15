import 'package:tut/data/networks/failure.dart';
import 'package:tut/data/networks/requests.dart';
import 'package:tut/domain/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequests loginRequests);
}
