import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pinboard_pin.g.dart';

// flutter pub run build_runner build
@collection
@HiveType(typeId: 6)
class PinboardPin {
  PinboardPin({
    required this.href,
    required this.description,
    required this.extended,
    required this.meta,
    required this.hash,
    required this.time,
    required this.shared,
    required this.toread,
    required this.tags,
  });

  Id id = Isar.autoIncrement;

  @HiveField(0)
  String href;
  @HiveField(1)
  String time;
  @HiveField(2)
  String meta;
  @HiveField(3)
  String description;
  @HiveField(4)
  String extended;
  @HiveField(5)
  String tags;
  @HiveField(6)
  String shared;
  @HiveField(7)
  String toread;
  @HiveField(8)
  String hash;

  // yes this is the same as what's in pinboard_pin.g.. will decide which
  // to delete based on how much this class changes
  factory PinboardPin.fromJson(Map<String, dynamic> json) => PinboardPin(
        href: json["href"],
        time: json["time"],
        meta: json["meta"],
        description: json["description"],
        extended: json["extended"],
        tags: json["tags"],
        shared: json["shared"],
        toread: json["toread"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "time": time,
        "meta": meta,
        "description": description,
        "extended": extended,
        "tags": tags,
        "shared": shared,
        "toread": toread,
        "hash": hash,
      };
}
