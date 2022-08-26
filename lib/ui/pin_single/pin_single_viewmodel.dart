import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/pin.dart';
import '../../services/pins.services.dart';

class PinSingleViewModel extends ReactiveViewModel {
  final String _id;

  final _firstPinFocusNode = FocusNode();
  final _pinsService = locator<PinsService>();
  late final removePin = _pinsService.removePin;
  late final updatePinContent = _pinsService.updatePinContent;

  PinSingleViewModel(this._id);

  List<Pin> get pins => _pinsService.pins;

  // Get the right pin
  Pin get pin => _pinsService.pins.where((pin) => pin.id == _id).first;

  FocusNode? getFocusNode(String id) {
    final index = pins.indexWhere((pin) => pin.id == id);
    return index == 0 ? _firstPinFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinsService];
}
