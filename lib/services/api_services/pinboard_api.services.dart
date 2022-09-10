import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

class PinboardAPIService with ReactiveServiceMixin {
  final _apiToken = ReactiveValue<String>(
    Hive.box('api_token').get('api_token', defaultValue: ""),
  );

  final Dio _dioClient = Dio();

  final _baseUrl = 'https://api.pinboard.in/v1';

  String get apiToken => _apiToken.value;

  void _saveToHive() => Hive.box('api_token').put('api_token', _apiToken.value);

  void setApiToken(String apiTok) {
    _apiToken.value = apiTok;
    _saveToHive();
    notifyListeners();
  }

  startLogin(String apiTok) async {
    setApiToken(apiTok);
    return getRecentPosts();
  }

  String _getAuthAppendage(String apiTok) {
    return '?auth_token=' + _apiToken.value + "&format=json";
  }

  Future<List<PinboardPin>> getRecentPosts() async {
    // Perform GET request to the endpoint "/users/<id>"
    Response pinboardPinData = await _dioClient
        .get(_baseUrl + '/posts/recent' + _getAuthAppendage(apiToken));

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
