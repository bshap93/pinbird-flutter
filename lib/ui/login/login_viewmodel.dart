import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/api_services/pinboard_pin.services.dart';
import '../../services/login.services.dart';

class LoginViewModel extends ReactiveViewModel {
  // final _firstPinFocusNode = FocusNode();
  final _pinboardPinService = locator<PinboardPinsService>();
  final _loginService = locator<LoginService>();
  late final startLogin = _loginService.startLogin;

  String get apiToken => _loginService.apiToken;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_loginService];
}
