import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../domain_services/pin.services.dart';
import '../../models/pinboard_pin/].dart';

class PinViewModel extends ReactiveViewModel {
  final String url;

  final _firstPinFocusNode = FocusNode();
  final _pinService = locator<PinService>();
  late final startDeletePin = _pinService.startDeletePin;
  late final startCreatePin = _pinService.startCreatePin;

  PinboardPin processPinUpdate(Map<String, dynamic> data) {
    PinboardPin pinToBeUpdated = PinboardPin(
        href: data["url"],
        description: data["title"],
        extended: data["description"],
        meta: data["meta"],
        hash: data["hash"],
        time: data["time"],
        shared: "",
        toread: "",
        tags: data["tags"]);

    if (data["private"]) {
      pinToBeUpdated.shared = "no";
    } else {
      pinToBeUpdated.toread = "yes";
    }

    if (data["read_later"]) {
      pinToBeUpdated.toread = "yes";
    } else {
      pinToBeUpdated.toread = "no";
    }

    return pinToBeUpdated;
  }

  PinboardPin processPinCreateData(Map<String, dynamic> data) {
    PinboardPin newPin = PinboardPin(
        href: data["url"],
        description: data["title"],
        extended: data["description"],
        meta: "",
        hash: "",
        time: "",
        shared: "",
        toread: "",
        tags: data["tags"]);

    if (data["private"]) {
      newPin.shared = "no";
    } else {
      newPin.toread = "yes";
    }

    if (data["read_later"]) {
      newPin.toread = "yes";
    } else {
      newPin.toread = "no";
    }

    return newPin;
  }

  PinViewModel(this.url);

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinService];
}
