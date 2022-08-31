import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pin_data.dart';
import 'package:pinboard_clone/services/tag.data.services.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/tag.dart';
import '../../services/pin_data.services.dart';

class PinsScreenViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  // pull in services via locator
  final _pinDataService = locator<PinDataService>();
  final _tagService = locator<TagService>();
  // pull in service methods view ViewModel
  late final removePin = _pinDataService.removePinDatum;
  late final updatePinContent = _pinDataService.updatePinDataContent;
  late final getTagByName = _tagService.getTagByName;

  // getters for pin and tag
  List<PinData> get pin_data => _pinDataService.pin_data;

  List<Tag> get tags => _tagService.tags;

  Tag get currentTag => _tagService.currentTag;

  void newPin() {
    _pinDataService.newPinDatum();
    _firstPinFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = pin_data.indexWhere((pin_datum) => pin_datum.id == id);
    return index == 0 ? _firstPinFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_pinDataService, _tagService];
}
