import 'package:get_it/get_it.dart';
import 'package:pinboard_clone/data_sources/pinboard_api/login.services.dart';

import '../services/pin.services.dart';
import '../data_sources/pinboard_api/api.services.dart';
import '../services/tag.sercives.dart';
// internal files

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => TagService());
  locator.registerLazySingleton(() => PinboardAPIV1Service());
  locator.registerLazySingleton(() => LoginServices());
  locator.registerLazySingleton(() => PinService());
}
