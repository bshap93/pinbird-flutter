import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
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
      testRequest().then((pins) {
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
    // return dioGetRecentPins();
  }

  logout() async {
    setApiToken("");
    return;
  }

  void logErrors(e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.response != null) {
      print('Dio error!');
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
      print('HEADERS: ${e.response?.headers}');
    } else {
      // Error due to setting up or sending the request
      print('Error sending request!');
      print(e.message);
    }
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

  Future<List<PinboardPin>> testRequest() async {
    // Perform GET request to the endpoint "/users/<id>"
    Response pinboardPinData = await dioClient
        .get(baseUrl + '/posts/recent' + getAuthAppendage(apiToken));

    List<PinboardPin> results = <PinboardPin>[];
    // Prints the raw data returned by the server
    // print('Pinboard pins: ${pinboardPinData.data["posts"]}');

    // Parsing the raw JSON data to the User class
    for (var _pinboardPin in pinboardPinData.data["posts"]) {
      PinboardPin p = PinboardPin.fromJson(_pinboardPin);
      results.add(p);
    }

    notifyListeners();

    return results;
  }
}
