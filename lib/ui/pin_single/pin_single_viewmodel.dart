import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/pin.services.dart';

class PinViewModel extends ReactiveViewModel {
  final String url;

  final _firstPinFocusNode = FocusNode();
  final _pinService = locator<PinService>();
  late final startDeletePin = _pinService.startDeletePin;

  PinViewModel(this.url);

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinService];
}
