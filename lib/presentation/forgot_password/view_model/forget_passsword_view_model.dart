import 'dart:async';

import 'package:tut/domain/usecase/forgetpassword_usecase.dart';
import 'package:tut/domain/usecase/login_usecase.dart';
import 'package:tut/presentation/base/base_viewmodel.dart';
import 'package:tut/presentation/common/freezed_data_classes.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  var email = '';

  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  fogetPassword() {}

  @override
  // TODO: implement inputEmail
  Sink get inputEmail => throw UnimplementedError();

  @override
  // TODO: implement outIsEmailValid
  Stream<bool> get outIsEmailValid => throw UnimplementedError();

  @override
  setEmail(String email) {
    // TODO: implement setEmail
    throw UnimplementedError();
  }

  @override
  // TODO: implement inputAreAllInputsValid
  Sink get inputAreAllInputsValid => throw UnimplementedError();

  @override
  // TODO: implement outAreAllInputsValid
  Stream<bool> get outAreAllInputsValid => throw UnimplementedError();
}

mixin LoginViewModelInputs {
  fogetPassword();
  setEmail(String email);
  Sink get inputEmail;
  Sink get inputAreAllInputsValid;
}
mixin LoginViewModelOutputs {
  Stream<bool> get outIsEmailValid;
  Stream<bool> get outAreAllInputsValid;
}
