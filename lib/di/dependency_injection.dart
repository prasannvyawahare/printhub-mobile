import 'package:flutter_application_1/utils/app_preferences.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/api_client.dart';

final serviceLocator = GetIt.instance;

void setupLocator() async{
  _dioConfiguration();
  //dio configuration
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<ApiClient>(() => ApiClient(serviceLocator<Dio>()));

  // SharedPreferences configuration
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPrefs);
  serviceLocator.registerSingleton<AppPreferences>(AppPreferences(sharedPrefs));


  //sl.registerLazySingleton<UserService>(() => UserService(sl<ApiClient>()));
}
