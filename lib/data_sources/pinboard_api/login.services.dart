import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

class LoginServices with ReactiveServiceMixin {
  final _apiToken = ReactiveValue<String>(
    Hive.box('api_token').get('api_token', defaultValue: ""),
  );

  String get apiToken => _apiToken.value;

  void _saveToHive() => Hive.box('api_token').put('api_token', _apiToken.value);

  void setApiToken(String apiTok) {
    _apiToken.value = apiTok;
    _saveToHive();
    notifyListeners();
  }

  logout() {
    _apiToken.value = "";
    _saveToHive();
    notifyListeners();
  }

  String getAuthAppendage(String apiTok) {
    return '?auth_token=' + _apiToken.value + "&format=json";
  }

  String getFullAppendage(Map<String, dynamic> params) {
    final fullAppendage = StringBuffer('?');

    fullAppendage.write('auth_token=' + _apiToken.value);

    if (params.isNotEmpty) {
      fullAppendage.write('&');
    }

    for (var key in params.keys) {
      if (key == params.keys.last) {
        fullAppendage.write("$key=${params[key]}");
      } else {
        fullAppendage.write("$key=${params[key]}&");
      }
    }
    // always prefer JSON to XML
    fullAppendage.write('&format=json');
    return fullAppendage.toString();
  }
}
