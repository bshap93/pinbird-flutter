import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/post/post.dart';
import '../../../services/pin/post.services.dart';

class PostSingleViewModel extends ReactiveViewModel {
  final String _id;

  final _firstPinFocusNode = FocusNode();
  final _pinDataService = locator<PostService>();
  late final removePin = _pinDataService.removePost;
  late final updatePinDataContent = _pinDataService.updatePinDataContent;

  PostSingleViewModel(this._id);

  List<Post> get posts => _pinDataService.posts;

  // Get the right pin
  Post get post => _pinDataService.posts.where((post) => post.id == _id).first;

  FocusNode? getFocusNode(String id) {
    final index = posts.indexWhere((post) => post.id == id);
    return index == 0 ? _firstPinFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinDataService];
}
