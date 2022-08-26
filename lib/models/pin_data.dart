import 'tag.dart';

class PinData {
  final String id;
  String url;
  String description;
  Tag tag;

  PinData(
      {required this.id,
      this.url = '',
      this.description = '',
      this.tag = const Tag(tag: "None")});
}
