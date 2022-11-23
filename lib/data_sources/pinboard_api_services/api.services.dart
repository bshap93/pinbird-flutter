import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:stacked/stacked.dart';
import './login.services.dart';

import '../../models/tag/tag.dart';

class PinboardAPIV1Service with ReactiveServiceMixin {
  final loginService = LoginServices();
  final Dio dioClient = Dio();

  final baseUrlV1 = 'https://api.pinboard.in/v1';
  final baseUrlV2 = 'https://api.pinboard.in/v2';

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

  Future<List<PinboardPin>> testRequest() async {
    // Perform GET request to the endpoint "/users/<id>"
    Response pinboardPinData = await dioClient.get(baseUrlV1 +
        '/posts/recent' +
        loginService.getAuthAppendage(loginService.apiToken));

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
  Future<List<PinboardPin>> getRecentPins({int? count, Tag? myTag}) async {
    List<PinboardPin> pinboardPinList = <PinboardPin>[];
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response pinboardPinData;
      if (myTag == null) {
        pinboardPinData = await dioClient.get(
            '$baseUrlV1/posts/recent${loginService.getAuthAppendage(loginService.apiToken)}&count=$count');
      } else {
        pinboardPinData = await dioClient.get(
            '$baseUrlV1/posts/recent${loginService.getAuthAppendage(loginService.apiToken)}&count=$count&tag=${myTag.tag}');
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

  Future<bool> createPinRemote(Map<String, dynamic> params) async {
    try {
      Response resp = await dioClient
          .post('$baseUrlV1/posts/add${loginService.getFullAppendage(params)}');

      print(resp.statusCode);
      return true;
    } on DioError catch (e) {
      logErrors(e);
    }

    return false;
  }

  Future<bool> deletePinRemote(Map<String, dynamic> params) async {
    try {
      Response resp = await dioClient.post(
          '$baseUrlV1/posts/delete${loginService.getFullAppendage(params)}');

      print(resp.statusCode);
      return true;
    } on DioError catch (e) {
      logErrors(e);
    }

    return false;
  }

  Future<PinboardPin> getPinRemote(
    Map<String, dynamic> params,
  ) async {
    late final PinboardPin result;

    Response pinboardPinData = await dioClient
        .get('$baseUrlV1/posts/get${loginService.getFullAppendage(params)}');

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


}
