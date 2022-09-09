import 'package:stacked/stacked.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginService with ReactiveServiceMixin {
  final _apiToken = ReactiveValue<String>(
    Hive.box('api_token').get('api_token', defaultValue: ""),
  );

  String get apiToken => _apiToken.value;

  startLogin(String apiTok) {
    // start the api cal
  }
}
