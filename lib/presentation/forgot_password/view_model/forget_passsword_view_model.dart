import 'dart:async';

import 'package:tut/domain/usecase/forgetpassword_usecase.dart';
import 'package:tut/presentation/base/base_viewmodel.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer.dart';

import 'package:tut/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  var email = '';

  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  fogetPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgetPasswordUseCase.excute(email)).fold((failure) {
      ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message);
    }, (supportMessage) {
      // inputState.add(SuccessState(supportMessage));
      inputState.add(ContentState());
    });
  }

  //inputs

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;
  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _areAllInputsValidStreamController.close();
  }

//outputs
  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((event) => isEmailValid(email));

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputAreAllInputsValid.add(null);
  }
}

mixin ForgetPasswordViewModelInputs {
  fogetPassword();
  setEmail(String email);
  Sink get inputEmail;
  Sink get inputAreAllInputsValid;
}
mixin ForgetPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;
  Stream<bool> get outAreAllInputsValid;
}
bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
