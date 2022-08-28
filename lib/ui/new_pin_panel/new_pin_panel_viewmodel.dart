import 'package:flutter/material.dart';
import 'package:pinboard_clone/services/tag.data.services.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/pin.dart';
import '../../models/pin_data.dart';
import '../../services/pin_data.services.dart';
import '../../services/pins.services.dart';

class NewPinPanelViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  final _pinDataService = locator<PinDataService>();
  late final updatePinContent = _pinDataService.updatePinDataContent;

  final _tagService = locator<TagService>();
  late final newTag = _tagService.newTag;

  List<PinData> get pins => _pinDataService.pin_data;

  // return pin id
  String newPinDataWithId() {
    _pinDataService.newPinDatum();
    // _firstPinFocusNode.requestFocus();
    String? _id = _pinDataService.newPinDataId();
    if (_id == null) {
      throw NullThrownError();
    } else {
      return _id;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinDataService];
}
