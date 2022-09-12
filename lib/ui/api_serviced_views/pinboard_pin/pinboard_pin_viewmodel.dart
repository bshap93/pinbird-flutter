import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/post/post.dart';
import '../../../services/api_services/pin_services/pin.services.dart';
import '../../../services/local_services/post.services.dart';

class PinViewModel extends ReactiveViewModel {
  final String _id;

  final _firstPinFocusNode = FocusNode();
  final _pinService = locator<PinService>();
  // late final removePin = _pinDataService.removePost;
  // late final updatePinDataContent = _pinDataService.updatePinDataContent;

  PinViewModel(this._id);

  // List<Post> get posts => _pinService.;

  // Get the right pin
  // Post get post => _pinService.posts.where((post) => post.id == _id).first;

  // FocusNode? getFocusNode(String id) {
  //   final index = posts.indexWhere((post) => post.id == id);
  //   return index == 0 ? _firstPinFocusNode : null;
  // }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinService];
}
