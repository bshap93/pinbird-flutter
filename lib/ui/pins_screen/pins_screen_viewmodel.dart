import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pin_data.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/pin.dart';
import '../../services/pin_data.services.dart';
import '../../services/pins.services.dart';

class PinsScreenViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  final _pinDataService = locator<PinDataService>();
  // late final toggleStatus = _pinsService.toggleStatus;
  late final removePin = _pinDataService.removePinDatum;
  late final updatePinContent = _pinDataService.updatePinDataContent;

  List<PinData> get pin_data => _pinDataService.pin_data;

  void newPin() {
    _pinDataService.newPinDatum();
    _firstPinFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = pin_data.indexWhere((pin_datum) => pin_datum.id == id);
    return index == 0 ? _firstPinFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinDataService];
}
