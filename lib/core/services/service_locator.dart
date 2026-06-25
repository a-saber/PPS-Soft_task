import 'package:get_it/get_it.dart';

import '../local_db/database_helper.dart';

class ServiceLocator {
  ServiceLocator._();
  static final sl = GetIt.instance;

  static Future<void> setupLocator() async {
    // TODO: register Data Sources, Repositories, and Cubits(if needed) here
    // ex: sl.registerLazySingleton<AuthRepo>(() => AuthRepo());

    sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  }

  // getters for registered services
  T get<T extends Object>() => sl.get<T>();


}