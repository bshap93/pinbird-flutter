import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:pinboard_clone/ui/pin_single/pin_single_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/pin/pin.services.dart';

class NewPinViewModel extends ReactiveViewModel {
  final _pinService = locator<PinService>();

  NewPinViewModel();

  processPinCreateData(Map<String, dynamic> data) {
    PinboardPin newPin = PinboardPin(
        href: data["url"],
        description: data["title"],
        extended: data["description"],
        meta: "",
        hash: "",
        time: "",
        shared: data["private"],
        toread: data["read_later"],
        tags: data["tags"]);

    _pinService.startCreatePin(newPin);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinService];
}

// It's not a full pin unitl it's been through Pinboard's API
// Hive struggles with null values so this class is to aid
// with using Pins before that.