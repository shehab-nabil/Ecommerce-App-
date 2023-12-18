import 'package:tut/data/networks/app_api.dart';
import 'package:tut/data/networks/requests.dart';
import 'package:tut/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClint _appServiceClint;

  RemoteDataSourceImpl(this._appServiceClint);
  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServiceClint.login(
        loginRequests.email, loginRequests.password);
  }
}
