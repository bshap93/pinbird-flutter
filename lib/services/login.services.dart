import 'package:stacked/stacked.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../app/locator.dart';
import 'api_services/pinboard_api.services.dart';

class LoginService with ReactiveServiceMixin {
  final _apiToken = ReactiveValue<String>(
    Hive.box('api_token').get('api_token', defaultValue: ""),
  );

  final _pinboardAPIservice = locator<PinboardAPIService>();

  String get apiToken => _apiToken.value;
  void _saveToHive() => Hive.box('api_token').put('api_token', _apiToken.value);

  void setApiToken(String apiTok) {
    _apiToken.value = apiTok;
    _saveToHive();
    notifyListeners();
  }

  startLogin(String apiTok) async {
    setApiToken(apiTok);
    return _pinboardAPIservice.getRecentPosts();
  }
}
