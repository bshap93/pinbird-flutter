import 'package:dio/dio.dart';
import 'package:pinboard_clone/services/tag/tag_api.services.dart';
import 'package:stacked/stacked.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/tag/tag.dart';

class TagService extends TagAPIService {
  final _tags = ReactiveValue<List<Tag>>(
    Hive.box('tags').get('tags', defaultValue: []).cast<Tag>(),
  );

  final _currentTag = ReactiveValue<Tag>(
    Hive.box('current_tag')
        .get('current_tag', defaultValue: const Tag(tag: "None", count: 1)),
  );

  List<Tag> get tags => _tags.value;

  Tag get currentTag => _currentTag.value;

  TagService() {
    listenToReactiveValues([_tags, _currentTag]);
  }

  Future<void> loadInTags() async {
    final tagData = await dioGetTags();
    for (var tag in tagData) {
      if (_tags.value.contains(tag)) {
        print("Hive has ${tag.tag}, with count ${tag.count}");
      } else {
        saveNewTag(tag.tag, tag.count);
      }
    }
    notifyListeners();
  }

  Future<List<Tag>> loadThenGetAllTags() async {
    await loadInTags();
    return this.tags;
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

  void saveNewTag(String _tag, int _count) {
    _tags.value.insert(0, Tag(tag: _tag, count: _count));
    _saveToHive();
    notifyListeners();
  }

  Tag getNewestTag() => _tags.value.elementAt(0);

  // Tags with equal tag string to be treated as equivalent and interchangeable
  Tag getTagByName(String tagStr) {
    List<Tag> tagsNamed =
        _tags.value.where((tag) => tag.tag == tagStr).toList();
    if (tagsNamed.length > 0) {
      return tagsNamed.first;
    } else {
      saveNewTag(tagStr, 0);
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

  Future<List<Tag>> dioGetTags() async {
    List<Tag> results = <Tag>[];
    try {
      Response tagData = await dioClient
          .get(baseUrl + '/tags/get' + getAuthAppendage(apiToken));

      print(tagData.data.toString());

      tagData.data.forEach((k, v) => results.add(Tag(tag: k, count: v)));

      notifyListeners();
    } on DioError catch (e) {
      logErrors(e);
    }
    // TODO empty placeholder return
    return results;
  }
}
