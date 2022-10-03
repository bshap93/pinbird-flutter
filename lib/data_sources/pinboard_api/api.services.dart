import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

import '../../models/tag/tag.dart';

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

  logout() {
    _apiToken.value = "";
    _saveToHive();
    notifyListeners();
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

  // TODO merge with getRecentPIns
  Future<List<PinboardPin>> getRecentPins({int count = 15, Tag? myTag}) async {
    List<PinboardPin> pinboardPinList = <PinboardPin>[];
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response pinboardPinData;
      if (myTag == null) {
        pinboardPinData = await dioClient.get(
            '$baseUrl/posts/recent${getAuthAppendage(apiToken)}&count=$count');
      } else {
        pinboardPinData = await dioClient.get(
            '$baseUrl/posts/recent${getAuthAppendage(apiToken)}&count=$count&tag=${myTag.tag}');
      }

      // print('Pinboard pins: ${pinboardPinData.data["posts"]}');
      for (var pinboardPin in pinboardPinData.data["posts"]) {
        PinboardPin myPin = PinboardPin.fromJson(pinboardPin);
        pinboardPinList.add(myPin);
      }

      notifyListeners();
    } on DioError catch (e) {
      logErrors(e);
    }

    return pinboardPinList;
  }

  Future<PinboardPin> dioGetPin(String url) async {
    // Perform GET request to the endpoint "/users/<id>"
    Map<String, dynamic> params = {};
    late final PinboardPin result;

    params["url"] = Uri.encodeComponent(url);
    Response pinboardPinData =
        await dioClient.get('$baseUrl/posts/get${getFullAppendage(params)}');

    // Prints the raw data returned by the server
    if (kDebugMode) {
      print('Pinboard pins: ${pinboardPinData.data}');
    }

    // Parsing the raw JSON data to the User class
    // If there are multiple pins with the same URL, only the first
    // will be returned.
    List posts = pinboardPinData.data["posts"];

    try {
      result = PinboardPin.fromJson(posts.first);
    } catch (e) {
      throw Exception("Response could not be parsed");
    }

    notifyListeners();

    return result;
  }

  // Deleting not allowed at the current time
  Future<void> dioDeletePin({required String url}) async {
    try {
      Response resp = await dioClient.delete(
          '$baseUrl/posts/delete?url=$url${getAuthAppendage(apiToken)}');

      if (kDebugMode) {
        print(resp.data);
      }
    } on DioError catch (e) {
      logErrors(e);
    }
  }
}
