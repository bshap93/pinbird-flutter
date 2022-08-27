import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/pin.dart';
import '../../models/pin_data.dart';
import '../../services/pin_data.services.dart';
import '../../services/pins.services.dart';

class NewPinPanelViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  final _pinDataService = locator<PinDataService>();
  // late final toggleStatus = _pinsService.toggleStatus;
  // late final removePin = _pinsService.removePin;
  late final updatePinContent = _pinDataService.updatePinDataContent;

  List<PinData> get pins => _pinDataService.pin_data;

  // return pin id
  String newPinWithId() {
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
