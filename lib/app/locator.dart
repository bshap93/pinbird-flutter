import 'package:get_it/get_it.dart';
import 'package:pinboard_clone/data_sources/pinboard_api_services/login.services.dart';

import '../domain_services/pin.services.dart';
import '../data_sources/pinboard_api_services/api.services.dart';
import '../domain_services/tag.sercives.dart';
// internal files

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => TagService());
  locator.registerLazySingleton(() => PinboardAPIV1Service());
  locator.registerLazySingleton(() => LoginServices());
  locator.registerLazySingleton(() => PinService());
}
