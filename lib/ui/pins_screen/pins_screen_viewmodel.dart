import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/post.dart';
import 'package:pinboard_clone/services/reactive_services/tag.data.services.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/tag.dart';
import '../../services/reactive_services/post.services.dart';

class PinsScreenViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  // pull in services via locator
  final _postService = locator<PostService>();
  final _tagService = locator<TagService>();
  // pull in service methods view ViewModel
  late final removePin = _postService.removePinDatum;
  late final updatePinContent = _postService.updatePinDataContent;
  late final getTagByName = _tagService.getTagByName;

  // getters for pin and tag
  List<Post> get posts => _postService.posts;

  List<Tag> get tags => _tagService.tags;

  Tag get currentTag => _tagService.currentTag;

  void newPin() {
    _postService.newPinDatum();
    _firstPinFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = posts.indexWhere((pin_datum) => pin_datum.id == id);
    return index == 0 ? _firstPinFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_postService, _tagService];
}
