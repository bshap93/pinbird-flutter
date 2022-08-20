import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/pin.dart';

class PinsScreenViewModel extends ReactiveViewModel {
  String url = '';

  final _pinsService = locator<PinsService>();

  void updateUrl(String url_v) {
    url = url_v;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
