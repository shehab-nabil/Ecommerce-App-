import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../app/constants.dart';
import '../response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClint;
  @POST('customer/login')
  Future<AuthenticationResponse> login(
      @Field('email') String email, @Field('password') String password);
}
