import 'package:isar/isar.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';

class AppStorage {
  static late Isar isar;
  static Future initIsar() async {
    isar = await Isar.open([
      PinboardPinSchema,
    ]);
  }
}
