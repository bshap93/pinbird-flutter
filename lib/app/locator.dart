import 'package:get_it/get_it.dart';
import 'package:pinboard_clone/services/api_services/pinboard_api.services.dart';
import 'package:pinboard_clone/services/login.services.dart';
import 'package:pinboard_clone/services/reactive_services/post.services.dart';
import 'package:pinboard_clone/services/reactive_services/tag.data.services.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PostService());
  locator.registerLazySingleton(() => TagService());
  locator.registerLazySingleton(() => PinboardAPIService());
  locator.registerLazySingleton(() => LoginService());
}
