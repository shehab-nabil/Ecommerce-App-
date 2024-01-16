import '../networks/app_api.dart';
import '../networks/requests.dart';
import '../response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
  Future<ForgetPasswordResponse> forgotPassword(String email);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClint;

  RemoteDataSourceImpl(this._appServiceClint);
  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServiceClint.login(
        loginRequests.email, loginRequests.password);
  }

  @override
  Future<ForgetPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClint.forgetPassword(email);
  }
}
