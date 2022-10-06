import 'package:dio/dio.dart';
import 'package:pinboard_clone/data_sources/pinboard_api/tag_api.services.dart';
import 'package:stacked/stacked.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/tag/tag.dart';

class TagService extends TagAPIService {
  // Non-API oriented functions
  final _tags = ReactiveValue<List<Tag>>(
    Hive.box('tags').get('tags', defaultValue: []).cast<Tag>(),
  );

  final _currentTag = ReactiveValue<Tag>(
    Hive.box('current_tag').get('current_tag', defaultValue: Tag(tag: "None")),
  );

  List<Tag> get tags => _tags.value;

  Tag get currentTag => _currentTag.value;

  TagService() {
    loadInTags();
    listenToReactiveValues([_tags, _currentTag]);
  }

  Future<bool> loadInTags() async {
    final tagData = await dioGetTags();
    if (tagData.isNotEmpty) {
      for (var tag in tagData) {
        if (_tags.value.contains(tag)) {
          print("Hive has ${tag.tag}, with count ${tag.count}");
        } else {
          saveNewTag(tag.tag, tag.count);
        }
      }
      notifyListeners();
      return true;
    } else {
      print("No tags retrieved from dio.");
      return false;
    }
  }

  bool saveNewTag(String _tag, int _count) {
    if (_tags.value.map((tag) => tag.tag).contains(_tag)) {
      print("${_tag} already exists.");
      return false;
    } else {
      _tags.value.insert(0, Tag(tag: _tag, count: _count));
      print("${_tag} tag created!");
      _saveToHive();
      notifyListeners();
      return true;
    }
  }

  bool setCurrentTag(String? tagName) {
    Tag? myTag = getTagByName(tagName);
    if (myTag == null) {
      print("No tag called $tagName");
      return false;
    } else {
      _currentTag.value = myTag;
      print("Current tag set to $tagName");
      _saveToHive();
      notifyListeners();
      return true;
    }
  }

  void _saveToHive() {
    Hive.box('tags').put('tags', _tags.value);
    Hive.box('current_tag').put('current_tag', _currentTag.value);
  }

  Tag getNewestTag() => _tags.value.elementAt(0);

  // Tags with equal tag string to be treated as equivalent and interchangeable
  Tag? getTagByName(String? tagStr) {
    try {
      if (_tags.value.isNotEmpty) {
        return _tags.value.where((tag) => tag.tag == tagStr).first;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
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

  @override
  Future<List<Tag>> dioGetTags() async {
    List<Tag> results = <Tag>[];
    try {
      Response tagData = await dioClient
          .get(baseUrlV1 + '/tags/get' + getAuthAppendage(apiToken));

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
