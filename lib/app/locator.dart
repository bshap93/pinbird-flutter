import 'package:get_it/get_it.dart';
import 'package:pinboard_clone/services/reactive_services/pin_data.services.dart';
import 'package:pinboard_clone/services/reactive_services/tag.data.services.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PinDataService());
  locator.registerLazySingleton(() => TagService());
}
