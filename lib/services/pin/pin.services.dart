import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

import '../../models/tag/tag.dart';
import '../api/api.services.dart';

class PinService extends PinboardAPIService {
  // Local storage from Hive to match with remote data from Pinboard
  PinService() {
    loadInRecentPins(15, null);
    listenToReactiveValues([_pins]);
  }

  startCreatePin(PinboardPin newPin) async {
    try {
      String requestString = prepareCreate(newPin);
    } on DioError catch (e) {
      logErrors(e);
    }

    return false;
  }

  final _pins = ReactiveValue<List<PinboardPin>>(
    Hive.box('pinboard_pins')
        .get('pinboard_pins', defaultValue: []).cast<PinboardPin>(),
  );

  // to be called to change our state values
  void _saveToHive() =>
      Hive.box('pinboard_pins').put('pinboard_pins', _pins.value);

  void emptyHive() {
    Hive.box('pinboard_pins').clear();
    notifyListeners();
  }

  // Composite Action Calls, invoking Dio API call methods

  List<PinboardPin> get pinboardPins => _pins.value;

  Future<bool> removePin(String url) async {
    throw Exception("to be implemented.");
  }

  // Dio API Calls
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

  bool saveNewPin(PinboardPin myPin) {
    if (_pins.value.map((pin) => pin.hash).contains(myPin.hash)) {
      // print("${myPin.description} already exists.");
      return false;
    } else {
      _pins.value.insert(0, myPin);
      if (kDebugMode) {
        print("${myPin.description} pin created.");
      }
      _saveToHive();
      notifyListeners();
      return true;
    }
  }

  Future<bool> loadInRecentPins(int count, Tag? myTag) async =>
      getRecentPins(myTag: myTag).then((pinData) {
        if (pinData.isNotEmpty) {
          for (var myPin in pinData) {
            if (_pins.value.contains(myPin)) {
              if (kDebugMode) {
                print("Hive has ${myPin.description} already.");
              }
            } else {
              if (kDebugMode) {
                print("New pin created: ${myPin.description}");
              }
              saveNewPin(myPin);
            }
          }
          notifyListeners();
          return true;
        } else {
          print("No pins retrieved from dio.");
          return false;
        }
      });

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

  signalChange() {
    notifyListeners();
  }

  String prepareCreate(PinboardPin newPin) {
    return "to be implemented";
  }
}
