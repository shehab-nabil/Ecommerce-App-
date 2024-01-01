import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/data/data_source/remote_data_source.dart';
import 'package:tut/data/networks/app_api.dart';
import 'package:tut/data/networks/dio_factory.dart';
import 'package:tut/data/networks/network_info.dart';
import 'package:tut/data/repository/repostiory_impl.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/login_usecase.dart';
import 'package:tut/presentation/login/view_model/view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // shared prefs instance
  final sharedpreferance = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedpreferance);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
