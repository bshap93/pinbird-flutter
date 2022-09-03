import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'dart:math';

import '../../../models/pin_data.dart';
import '../../../models/tag.dart';

class PinDataService with ReactiveServiceMixin {
  final _pin_data = ReactiveValue<List<PinData>>(
    Hive.box('pin_data').get('pin_data', defaultValue: []).cast<PinData>(),
  );

  final _random = Random();

  List<PinData> get pin_data => _pin_data.value;

  List<PinData> pin_data_by_tag(String _tagName) {
    return pin_data.where((pin) => pin.tag.tag == _tagName).toList();
  }

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
      _pin_data.value[index].tag = tag;
      _saveToHive();
      return true;
    } else {
      return false;
    }
  }
}
