import 'package:get_it/get_it.dart';
import 'package:pinboard_clone/services/api_services/dio_client.dart';
import 'package:pinboard_clone/services/login.services.dart';
import 'package:pinboard_clone/services/reactive_services/post.services.dart';
import 'package:pinboard_clone/services/reactive_services/tag.data.services.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PostService());
  locator.registerLazySingleton(() => TagService());
  locator.registerLazySingleton(() => PinboardPinsService());
  locator.registerLazySingleton(() => LoginService());
}
