import 'package:hive/hive.dart';
part 'tag.g.dart';

@HiveType(typeId: 2)
class Tag {
  @HiveField(0)
  final String tag;
  @HiveField(1)
  final int count;

  const Tag({this.tag = 'None', this.count = 0});
}
