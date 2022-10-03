import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

import '../models/tag/tag.dart';
import '../data_sources/pinboard_api/api.services.dart';

class PinService extends PinboardAPIService {
  // Local storage from Hive to match with remote data from Pinboard
  PinService() {
    loadInRecentPins(15, null);
    listenToReactiveValues([_pins]);
  }

  final _pins = ReactiveValue<List<PinboardPin>>(
    Hive.box('pinboard_pins')
        .get('pinboard_pins', defaultValue: []).cast<PinboardPin>(),
  );

  signalChange() {
    notifyListeners();
  }

  List<PinboardPin> get pinboardPins => _pins.value;

  // to be called to change our state values
  void _saveToHive() =>
      Hive.box('pinboard_pins').put('pinboard_pins', _pins.value);

  void emptyHive() {
    Hive.box('pinboard_pins').clear();
    notifyListeners();
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

  // Composite Action Calls, invoking Dio API call methods

  // Dio API Calls

  startCreatePin(PinboardPin newPin) async {
    try {
      String requestString = prepareCreate(newPin);
    } on DioError catch (e) {
      logErrors(e);
    }

    return false;
  }

  Future<bool> removePin(String url) async {
    throw Exception("to be implemented.");
  }

  String prepareCreate(PinboardPin newPin) {
    return "to be implemented";
  }
}
