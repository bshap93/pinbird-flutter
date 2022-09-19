import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:pinboard_clone/services/tag/tag.sercives.dart';
import 'package:pinboard_clone/ui/api_serviced_views/pin_single/pin_single.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/tag/tag.dart';
import '../../../services/pin/pin.services.dart';

class TagsListViewModel extends ReactiveViewModel {
  final _tagsService = locator<TagService>();

  late final setCurrentTag = _tagsService.setCurrentTag;

  Future<List<Tag>> get tags => _tagsService.tags;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_tagsService];
}
