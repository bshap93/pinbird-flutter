import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

class PinboardAPIService with ReactiveServiceMixin {
  final _apiToken = ReactiveValue<String>(
    Hive.box('api_token').get('api_token', defaultValue: ""),
  );

  final Dio dioClient = Dio();

  final baseUrl = 'https://api.pinboard.in/v1';

  String get apiToken => _apiToken.value;

  void _saveToHive() => Hive.box('api_token').put('api_token', _apiToken.value);

  Future<bool> validateApiToken(String apiTok) async {
    try {
      dioGetRecentPins().then((pins) {
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }

    return false;
  }

  void setApiToken(String apiTok) {
    _apiToken.value = apiTok;
    _saveToHive();
    notifyListeners();
  }

  startLogin(String apiTok) async {
    setApiToken(apiTok);
    return dioGetRecentPins();
  }

  String getAuthAppendage(String apiTok) {
    return '?auth_token=' + _apiToken.value + "&format=json";
  }

  Future<List<PinboardPin>> dioGetRecentPins() async {
    // Perform GET request to the endpoint "/users/<id>"
    Response pinboardPinData = await dioClient
        .get(baseUrl + '/posts/recent' + getAuthAppendage(apiToken));

    List<PinboardPin> results = <PinboardPin>[];
    // Prints the raw data returned by the server
    print('Pinboard pins: ${pinboardPinData.data["posts"]}');

    // Parsing the raw JSON data to the User class
    for (var _pinboardPin in pinboardPinData.data["posts"]) {
      PinboardPin p = PinboardPin.fromJson(_pinboardPin);
      results.add(p);
    }

    notifyListeners();

    return results;
  }
}
