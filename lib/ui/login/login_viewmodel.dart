import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../data_sources/pinboard_api/api.services.dart';

class LoginViewModel extends ReactiveViewModel {
  // final _firstPinFocusNode = FocusNode();
  final _pinboardPinService = locator<PinboardAPIService>();
  late final startLogin = _pinboardPinService.setApiToken;
  late final setApiToken = _pinboardPinService.setApiToken;
  late final validateAPIToken = _pinboardPinService.validateApiToken;

  String get apiToken => _pinboardPinService.apiToken;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinboardPinService];
}
