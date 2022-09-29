import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pin_single/pin_single_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/pin/pin.services.dart';

class NewPinViewModel extends ReactiveViewModel {
  final _pinService = locator<PinService>();

  NewPinViewModel();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinService];
}
