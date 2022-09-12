import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/api_services/pin_services/pin.services.dart';
import '../../../services/api_services/pinboard_api.services.dart';

class RecentPinsViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  // pull in services via locator
  final _pinboardPinsService = locator<PinService>();
  late final logout = _pinboardPinsService.logout;

  // pull in service methods view ViewModel
  // getters for pin and tag
  Future<List<PinboardPin>> get recent_pins =>
      _pinboardPinsService.dioGetRecentPins();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinboardPinsService];

  tryDelete(PinboardPin post) {}
}
