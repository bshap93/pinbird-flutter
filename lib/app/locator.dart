import 'package:get_it/get_it.dart';
import 'package:pinboard_clone/models/pin_data.dart';
import 'package:pinboard_clone/services/pin_data.services.dart';
import '../services/pins.services.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => PinDataService());
}
