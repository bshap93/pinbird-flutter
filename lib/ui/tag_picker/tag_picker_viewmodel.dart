import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pin_data.dart';
import 'package:pinboard_clone/services/tag.data.services.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/tag.dart';
import '../../services/pin_data.services.dart';

class TagPickerViewModel extends ReactiveViewModel {
  // pull in services via locator
  final _pinDataService = locator<PinDataService>();
  final _tagService = locator<TagService>();
  late final setCurrentTag = _tagService.setCurrentTag;

  // Getters
  List<Tag> get tags => _tagService.tags;
  Tag get currentTag => _tagService.currentTag;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_pinDataService, _tagService];
}
