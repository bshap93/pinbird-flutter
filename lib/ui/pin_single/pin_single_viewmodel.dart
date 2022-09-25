import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/pin/pin.services.dart';

class PinViewModel extends ReactiveViewModel {
  final String url;

  final _firstPinFocusNode = FocusNode();
  final _pinService = locator<PinService>();

  PinViewModel(this.url);

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinService];
}
