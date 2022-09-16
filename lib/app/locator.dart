import 'package:get_it/get_it.dart';

import '../services/pin/pin.services.dart';
import '../services/api/api.services.dart';
import '../services/tag/tag.sercives.dart';
import '../services/pin/post.services.dart';
// internal files

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PostService());
  locator.registerLazySingleton(() => TagService());
  locator.registerLazySingleton(() => PinboardAPIService());
  locator.registerLazySingleton(() => PinService());
}
