import '../networks/app_api.dart';
import '../networks/requests.dart';
import '../response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClint;

  RemoteDataSourceImpl(this._appServiceClint);
  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServiceClint.login(
        loginRequests.email, loginRequests.password);
  }
}
