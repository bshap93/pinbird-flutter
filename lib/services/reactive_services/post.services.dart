import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'dart:math';

import '../../models/post.dart';
import '../../../models/tag.dart';

class PostService with ReactiveServiceMixin {
  final _posts = ReactiveValue<List<Post>>(
    Hive.box('posts').get('posts', defaultValue: []).cast<Post>(),
  );

  final _random = Random();

  List<Post> get posts => _posts.value;

  List<Post> posts_by_tag(String _tagName) {
    return posts.where((pin) => pin.tag.tag == _tagName).toList();
  }

  PostService() {
    listenToReactiveValues([_posts]);
  }

  String _randomId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  void _saveToHive() => Hive.box('posts').put('posts', _posts.value);

  void newPinDatum() {
    String _id = _randomId();
    _posts.value.insert(0, Post(id: _id));
    _saveToHive();
    notifyListeners();
  }

  String? newPinDataId() {
    return _posts.value.first.id;
  }

  bool removePinDatum(String id) {
    final index = _posts.value.indexWhere((pin_datum) => pin_datum.id == id);
    if (index != -1) {
      _posts.value.removeAt(index);
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updatePinDataContent({
    String id = '',
    String url = '',
    String description = '',
    Tag tag = const Tag(tag: "None"),
  }) {
    final index = _posts.value.indexWhere((pin_datum) => pin_datum.id == id);
    if (index != -1) {
      _posts.value[index].url = url;
      _posts.value[index].description = description;
      _posts.value[index].tag = tag;
      _saveToHive();
      return true;
    } else {
      return false;
    }
  }
}
