import 'package:hive/hive.dart';

import 'tag.dart';
part 'post.g.dart';

@HiveType(typeId: 3)
class Post {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String url;
  @HiveField(2)
  String description;
  @HiveField(3)
  Tag tag;
  @HiveField(4)
  final DateTime datetime = DateTime.now();

  Post(
      {required this.id,
      this.url = '',
      this.description = '',
      this.tag = const Tag(tag: "None")});
}
