import 'package:get_it/get_it.dart';
import '../services/pins.services.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PinsService());
}
