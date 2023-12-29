import 'dart:async';

import 'package:tut/domain/usecase/login_usecase.dart';
import 'package:tut/presentation/base/base_viewmodel.dart';
import 'package:tut/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final LoginUseCase _loginUseCase;
  var loginObject = LoginObject('', '');

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }
  // inputs
  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;
  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject = loginObject.copyWith(userName: username);
  }

  @override
  login() async {
    (await _loginUseCase.excute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold((failure) {
      print(failure);
    }, (data) => print(data));
  }

  //outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordvalid(password));

  @override
  Stream<bool> get outIsUserNameValid => _passwordStreamController.stream
      .map((userName) => _isUserNamevalid(userName));

  bool _isPasswordvalid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNamevalid(String userName) {
    return userName.isNotEmpty;
  }
}

mixin LoginViewModelInputs {
  setUserName(String username);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
}
mixin LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
}
