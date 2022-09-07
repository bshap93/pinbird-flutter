import 'package:json_annotation/json_annotation.dart';

part 'pinboard_pin.g.dart';

@JsonSerializable()
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

  String href;
  String time;
  String meta;
  String description;
  String extended;
  String tags;
  String shared;
  String toread;
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
