import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/pin.dart';
import '../../services/pins.services.dart';

class PinsScreenViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  final _pinsService = locator<PinsService>();
  late final toggleStatus = _pinsService.toggleStatus;
  late final removePin = _pinsService.removePin;
  late final updatePinContent = _pinsService.updatePinContent;

  List<Pin> get pins => _pinsService.pins;

  void newPin() {
    _pinsService.newPin();
    _firstPinFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = pins.indexWhere((pin) => pin.id == id);
    return index == 0 ? _firstPinFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinsService];
}
