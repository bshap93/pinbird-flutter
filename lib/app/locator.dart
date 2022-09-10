import 'package:get_it/get_it.dart';

import '../services/api_services/pin_services/pin.services.dart';
import '../services/api_services/pinboard_api.services.dart';
import '../services/reactive_services/post.services.dart';
import '../services/reactive_services/tag.data.services.dart';
// internal files

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PostService());
  locator.registerLazySingleton(() => TagService());
  locator.registerLazySingleton(() => PinboardAPIService());
  locator.registerLazySingleton(() => PinService());
}
