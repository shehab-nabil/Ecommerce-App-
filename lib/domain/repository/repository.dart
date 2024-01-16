import '../../data/networks/failure.dart';
import '../../data/networks/requests.dart';
import '../models/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequests loginRequests);
  Future<Either<Failure, String>> forgotPassword(String email);
}
