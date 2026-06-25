import 'package:get_it/get_it.dart';

class ServiceLocator {
  ServiceLocator._();
  static final sl = GetIt.instance;

  static Future<void> setupLocator() async {
    // TODO: register Data Sources, Repositories, and Cubits(if needed) here
    // ex: sl.registerLazySingleton<AuthRepo>(() => AuthRepo());

  }


}