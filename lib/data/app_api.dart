import 'package:retrofit/http.dart';
import 'package:tut/app/constants.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClint {}
