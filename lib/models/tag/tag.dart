import 'package:hive/hive.dart';
part 'tag.g.dart';

@HiveType(typeId: 2)
class Tag {
  @HiveField(0)
  final String tag;
  @HiveField(1)
  final int count;

  const Tag({this.tag = 'None', this.count = 0});

  factory Tag.fromJson(Map<String, String> json) => Tag(
        tag: json.keys.first,
        count: int.parse(json.values.first),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {};
    result[this.tag] = this.count;
    return result;
  }
}
