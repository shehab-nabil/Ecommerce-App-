import 'package:dartz/dartz.dart';
import 'package:tut/data/networks/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> excute(In input);
}
