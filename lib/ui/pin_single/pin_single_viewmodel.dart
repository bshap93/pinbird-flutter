import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/pin.dart';
import '../../models/pin_data.dart';
import '../../services/pin_data.services.dart';
import '../../services/pins.services.dart';

class PinSingleViewModel extends ReactiveViewModel {
  final String _id;

  final _firstPinFocusNode = FocusNode();
  final _pinDataService = locator<PinDataService>();
  late final removePin = _pinDataService.removePinDatum;
  late final updatePinContent = _pinDataService.updatePinDataContent;

  PinSingleViewModel(this._id);

  List<PinData> get pin_data => _pinDataService.pin_data;

  // Get the right pin
  PinData get pin_datum =>
      _pinDataService.pin_data.where((pin_datum) => pin_datum.id == _id).first;

  FocusNode? getFocusNode(String id) {
    final index = pin_data.indexWhere((pin_datum) => pin_datum.id == id);
    return index == 0 ? _firstPinFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinDataService];
}
