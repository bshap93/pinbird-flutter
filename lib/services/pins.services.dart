import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:stacked/stacked.dart';
import 'dart:math';

import '../models/pin.dart';

class PinsService with ReactiveServiceMixin {
  final _pins = ReactiveValue<List<Pin>>(
    Hive.box('pins').get('pins', defaultValue: []).cast<Pin>(),
  );
  final _random = Random();

  List<Pin> get pins => _pins.value;

  PinsService() {
    listenToReactiveValues([_pins]);
  }

  String _randomId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  void _saveToHive() => Hive.box('pins').put('pins', _pins.value);

  void newPin() {
    String _id = _randomId();
    print("ID_0 is ${_id}");
    _pins.value.insert(0, Pin(id: _id, wasRead: false));
    _saveToHive();
    notifyListeners();
  }

  String? newPinId() {
    return _pins.value.first.id;
  }

  bool removePin(String id) {
    final index = _pins.value.indexWhere((pin) => pin.id == id);
    if (index != -1) {
      _pins.value.removeAt(index);
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool toggleStatus(String id) {
    final index = _pins.value.indexWhere((pin) => pin.id == id);
    if (index != -1) {
      _pins.value[index].wasRead = !_pins.value[index].wasRead;
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updatePinDataContent({String id = '', String url = ''}) {
    final index = _pins.value.indexWhere((pin) => pin.id == id);
    if (index != -1) {
      _pins.value[index].url = url;
      _saveToHive();
      return true;
    } else {
      return false;
    }
  }
}
