import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../models/pin.dart';

class SinglePinService with ReactiveServiceMixin {
  final String pinId;

  final _pin = ReactiveValue<Pin>(
      // Get a specific pin from the hive box pins... Right now _pin will receive a list of
      // pins, causing an error.
      Hive.box('pins').get('pins', defaultValue: []).cast<Pin>());
  // Hive.box('pins').get('pins', defaultValue: []).cast<Pin>());

  Pin get pin => _pin.value;

  SinglePinService(this.pinId) {
    listenToReactiveValues([_pin]);
  }

  void _saveToHive() => Hive.box('pins').put('pins', _pin.value);

  bool removePin(String id) {
    // final index = _pins.value.indexWhere((pin) => pin.id == id);
    // if (index != -1) {
    //   _pins.value.removeAt(index);
    //   _saveToHive();
    //   notifyListeners();
    //   return true;
    // } else {
    //   return false;
    // }
    return false;
  }

  bool updatePinContent(String id, String text) {
    // final index = _pins.value.indexWhere((pin) => pin.id == id);
    // if (index != -1) {
    //   _pins.value[index].url = text;
    //   _saveToHive();
    //   return true;
    // } else {
    //   return false;
    // }
    return false;
  }
}
