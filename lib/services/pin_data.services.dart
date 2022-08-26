import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../models/pin.dart';
import '../models/pin_data.dart';

class PinsService with ReactiveServiceMixin {
  final _pin_data = ReactiveValue<List<Pin>>(
    Hive.box('pin_data').get('pin_data', defaultValue: []).cast<PinData>(),
  );

  List<Pin> get pin_data => _pin_data.value;
}
