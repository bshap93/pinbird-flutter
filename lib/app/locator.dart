import 'package:get_it/get_it.dart';

import '../services/pin.services.dart';
import '../data_sources/pinboard_api/api.services.dart';
import '../services/tag.sercives.dart';
// internal files

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => TagService());
  locator.registerLazySingleton(() => PinboardAPIService());
  locator.registerLazySingleton(() => PinService());
}
