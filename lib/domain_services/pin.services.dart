import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

import '../models/tag/tag.dart';
import '../data_sources/pinboard_api_services/api.services.dart';

class PinService with ReactiveServiceMixin {
  // Local storage from Hive to match with remote data from Pinboard
  final apiConnection = PinboardAPIV1Service();
  PinService() {
    loadInRecentPins(15, null);
    listenToReactiveValues([_pins]);
  }

  final _pins = ReactiveValue<List<PinboardPin>>(
    Hive.box('pinboard_pins')
        .get('pinboard_pins', defaultValue: []).cast<PinboardPin>(),
  );

  // Future<http.Response> fetchAllPins(http)

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

  Future<bool> startCreatePin(PinboardPin newPin) async {
    Map<String, dynamic> params = {};

    params["url"] = newPin.href;
    params["description"] = newPin.description;

    if (newPin.tags.isNotEmpty) params["tags"] = newPin.tags;

    if (newPin.extended.isNotEmpty) params["extended"] = newPin.extended;

    if (newPin.shared.isNotEmpty) params["shared"] = newPin.shared;

    if (newPin.toread.isNotEmpty) params["toread"] = newPin.toread;

    try {
      await apiConnection.createPinRemote(params);
      return true;
    } catch (_) {
      if (kDebugMode) {
        print("Could not create pin.");
      }
      return false;
    }
  }

  Future<bool> startUpdateP0in(PinboardPin pinToBeUpdated) async {
    Map<String, dynamic> params = {};

    params["url"] = pinToBeUpdated.href;
    params["description"] = pinToBeUpdated.description;

    if (pinToBeUpdated.tags.isNotEmpty) params["tags"] = pinToBeUpdated.tags;

    if (pinToBeUpdated.extended.isNotEmpty)
      params["extended"] = pinToBeUpdated.extended;

    if (pinToBeUpdated.shared.isNotEmpty)
      params["shared"] = pinToBeUpdated.shared;

    if (pinToBeUpdated.toread.isNotEmpty)
      params["toread"] = pinToBeUpdated.toread;

    if (pinToBeUpdated.meta.isNotEmpty) params["meta"] = pinToBeUpdated.meta;

    if (pinToBeUpdated.time.isNotEmpty) params["time"] = pinToBeUpdated.time;

    if (pinToBeUpdated.hash.isNotEmpty) params["hash"] = pinToBeUpdated.hash;

    try {
      // method used to create is also used to update
      await apiConnection.createPinRemote(params);
      return true;
    } catch (_) {
      if (kDebugMode) {
        print("Could not update pin.");
      }
      return false;
    }
  }

  Future<PinboardPin> startGetPin(String url) {
    Map<String, dynamic> params = {};

    params["url"] = Uri.encodeComponent(url);

    return apiConnection.getPinRemote(params);
  }

  Future<List<PinboardPin>> startGetRecentPins({int count = 15, Tag? myTag}) {
    return apiConnection.getRecentPins(count: count, myTag: myTag);
  }

  Future<bool> loadInRecentPins(int count, Tag? myTag) async =>
      apiConnection.getRecentPins(myTag: myTag).then((pinData) {
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

  Future<bool> startDeletePin(String myUrl) async {
    Map<String, dynamic> params = {};

    params["url"] = myUrl;
    try {
      await apiConnection.deletePinRemote(params).then((resp) {
        //
      });
      return true;
    } catch (_) {
      if (kDebugMode) {
        print("Could not delete pin.");
      }
      return false;
    }
  }

  List<PinboardPin> parsePinboardPins(Response<dynamic> pinboardPinData) {
    List<PinboardPin> pinboardPinList = <PinboardPin>[];
    for (var pinboardPin in pinboardPinData.data["posts"]) {
      PinboardPin myPin = PinboardPin.fromJson(pinboardPin);
      pinboardPinList.add(myPin);
    }
    return pinboardPinList;
  }

  bool saveAllPinWorker(PinboardPin myPin) {
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
  // Future<PinboardPin> getPin(String url) async {
  //   return await apiConnection.dioGetPinRemote(url);
  // }
}
