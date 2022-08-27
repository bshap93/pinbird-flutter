import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../models/pin_data.dart';
import '../models/tag.dart';

class PinDataService with ReactiveServiceMixin {
  final _pin_data = ReactiveValue<List<PinData>>(
    Hive.box('pin_data').get('pin_data', defaultValue: []).cast<PinData>(),
  );

  final _random = Random();

  List<PinData> get pin_data => _pin_data.value;

  PinDataService() {
    listenToReactiveValues([_pin_data]);
  }

  String _randomId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  void _saveToHive() => Hive.box('pin_data').put('pin_data', _pin_data.value);

  void newPinDatum() {
    String _id = _randomId();
    print("ID_0 is ${_id}");
    _pin_data.value.insert(0, PinData(id: _id));
    _saveToHive();
    notifyListeners();
  }

  String? newPinDataId() {
    return _pin_data.value.first.id;
  }

  bool removePinDatum(String id) {
    final index = _pin_data.value.indexWhere((pin_datum) => pin_datum.id == id);
    if (index != -1) {
      _pin_data.value.removeAt(index);
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updatePinDataContent({
    String id = '',
    String url = '',
    String description = '',
    Tag tag = const Tag(tag: "None"),
  }) {
    final index = _pin_data.value.indexWhere((pin_datum) => pin_datum.id == id);
    if (index != -1) {
      _pin_data.value[index].url = url;
      _pin_data.value[index].description = description;
      // TODO: Implement tags, but for now just let tag be None
      _saveToHive();
      return true;
    } else {
      return false;
    }
  }
}
