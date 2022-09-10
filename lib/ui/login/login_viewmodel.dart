import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/api_services/pinboard_api.services.dart';
import '../../services/login.services.dart';

class LoginViewModel extends ReactiveViewModel {
  // final _firstPinFocusNode = FocusNode();
  final _pinboardPinService = locator<PinboardAPIService>();
  final _loginService = locator<LoginService>();
  late final startLogin = _pinboardPinService.startLogin;
  late final setApiToken = _pinboardPinService.setApiToken;

  String get apiToken => _pinboardPinService.apiToken;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinboardPinService];
}
