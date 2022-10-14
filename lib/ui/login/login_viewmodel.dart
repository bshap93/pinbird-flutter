import 'package:pinboard_clone/data_sources/pinboard_api_services/login.services.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../data_sources/pinboard_api_services/api.services.dart';

class LoginViewModel extends ReactiveViewModel {
  // final _firstPinFocusNode = FocusNode();
  final _pinboardPinService = locator<PinboardAPIV1Service>();
  final _loginService = locator<LoginServices>();
  late final startLogin = _loginService.setApiToken;
  late final setApiToken = _loginService.setApiToken;
  // late final validateAPIToken = _pinboardPinService.validateApiToken;

  String get apiToken => _loginService.apiToken;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinboardPinService];
}
