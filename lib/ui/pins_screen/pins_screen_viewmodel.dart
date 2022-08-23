import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/pin.dart';

class PinsScreenViewModel {
  final List<Pin> _pins =
      Hive.box('pins').get('pins', defaultValue: []).cast<Pin>();

  List<Pin> get pins => _pins;

  final _firstPinFocusNode = FocusNode();

  final _random = Random();

  String _randomId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  bool toggleStatus(String id) {
    final index = _pins.indexWhere((pin) => pin.id == id);
    if (index != -1) {
      _pins[index].wasRead = !_pins[index].wasRead;
      _saveToHive();
      // notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool removePin(String id) {
    final index = _pins.indexWhere((pin) => pin.id == id);
    if (index != -1) {
      _pins.removeAt(index);
      _saveToHive();
      // notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updatePinContent(String id, String text) {
    final index = _pins.indexWhere((pin) => pin.id == id);
    if (index != -1) {
      _pins[index].url = text;
      _saveToHive();
      return true;
    } else {
      return false;
    }
  }

  void _saveToHive() => Hive.box('pins').put('pins', _pins);

  void newPin() {
    // _pinsService.newPin();
    _pins.insert(0, Pin(id: _randomId()));
    _saveToHive();
    // notifyListeners();
    _firstPinFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = _pins.indexWhere((pin) => pin.id == id);
    return index == 0 ? _firstPinFocusNode : null;
  }
}
