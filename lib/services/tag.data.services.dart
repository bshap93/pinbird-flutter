import 'package:stacked/stacked.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/tag.dart';

class TagService with ReactiveServiceMixin {
  final _tags = ReactiveValue<List<Tag>>(
    Hive.box('tags').get('tags', defaultValue: []).cast<Tag>(),
  );

  List<Tag> get tags => _tags.value;

  TagService() {
    listenToReactiveValues([_tags]);
  }

  void _saveToHive() => Hive.box('tags').put('tags', _tags.value);

  void newTag(String _tag) {
    _tags.value.insert(0, Tag(tag: _tag));
    _saveToHive();
    notifyListeners();
  }

  bool removeTag(String _t) {
    final index = _tags.value.indexWhere((_tag) => _tag.tag == _t);
    if (index != -1) {
      _tags.value.removeAt(index);
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
