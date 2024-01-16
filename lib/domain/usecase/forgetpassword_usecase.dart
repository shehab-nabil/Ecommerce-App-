import 'package:dartz/dartz.dart';
import 'package:tut/data/networks/failure.dart';

import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/base_usecase.dart';

class ForgetPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;

  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> excute(String email) async {
    return await _repository.forgotPassword(email);
  }
}
