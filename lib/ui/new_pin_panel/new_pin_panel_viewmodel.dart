import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/pin.dart';
import '../../services/pins.services.dart';

class NewPinPanelViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  final _pinsService = locator<PinsService>();
  // late final toggleStatus = _pinsService.toggleStatus;
  // late final removePin = _pinsService.removePin;
  late final updatePinContent = _pinsService.updatePinContent;

  List<Pin> get pins => _pinsService.pins;

  // return pin id
  String newPinWithId() {
    _pinsService.newPin();
    // _firstPinFocusNode.requestFocus();
    String? _id = _pinsService.newPinId();
    if (_id == null) {
      throw NullThrownError();
    } else {
      return _id;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinsService];
}