import 'package:hive/hive.dart'; //import Hive
part 'pin.g.dart';

@HiveType(typeId: 0)
class Pin {
  @HiveField(0) //
  final String id;
  @HiveField(1) //
  bool wasRead;
  @HiveField(2) //
  String url;
  @HiveField(3) //
  String description;

  Pin(
      {required this.id,
      this.wasRead = false,
      this.url = '',
      required this.description});
}
