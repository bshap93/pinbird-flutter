import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/login.services.dart';

class LoginViewModel extends ReactiveViewModel {
  // final _firstPinFocusNode = FocusNode();
  final _loginService = locator<LoginService>();
  late final startLogin = _loginService.startLogin;

  String get apiToken => _loginService.apiToken;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_loginService];
}
