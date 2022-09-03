import 'package:stacked/stacked.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/tag.dart';

class TagService with ReactiveServiceMixin {
  final _tags = ReactiveValue<List<Tag>>(
    Hive.box('tags').get('tags', defaultValue: []).cast<Tag>(),
  );

  final _currentTag = ReactiveValue<Tag>(
    Hive.box('current_tag').get('current_tag', defaultValue: Tag(tag: "None")),
  );

  List<Tag> get tags => _tags.value;

  Tag get currentTag => _currentTag.value;

  TagService() {
    listenToReactiveValues([_tags]);
  }

  void setCurrentTag(String tagName) {
    Tag toSetTag = getTagByName(tagName);
    _currentTag.value = toSetTag;
    _saveToHive();
    notifyListeners();
  }

  void _saveToHive() {
    Hive.box('tags').put('tags', _tags.value);
    Hive.box('current_tag').put('current_tag', _currentTag.value);
  }

  void newTag(String _tag) {
    _tags.value.insert(0, Tag(tag: _tag));
    _saveToHive();
    notifyListeners();
  }

  Tag getNewestTag() => _tags.value.elementAt(0);

  // Tags with equal tag string to be treated as equivalent and interchangeable
  Tag getTagByName(String name) {
    List<Tag> tagsNamed = _tags.value.where((tag) => tag.tag == name).toList();
    if (tagsNamed.length > 0) {
      return tagsNamed.first;
    } else {
      newTag(name);
      return getNewestTag();
    }
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
