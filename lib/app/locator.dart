import 'package:get_it/get_it.dart';
import '../services/pins.services.dart';
import '../services/single_pin.services.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PinsService());
  locator.registerLazySingleton(() => SinglePinService("dummyId"));
}
