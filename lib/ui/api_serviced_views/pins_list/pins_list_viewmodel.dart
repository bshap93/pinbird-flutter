import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:pinboard_clone/services/tag/tag.sercives.dart';
import 'package:pinboard_clone/ui/api_serviced_views/pin_single/pin_single.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/tag/tag.dart';
import '../../../services/pin/pin.services.dart';

class PinsListViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  // pull in services via locator
  final _pinboardPinsService = locator<PinService>();
  final _tagsService = locator<TagService>();
  late final logout = _pinboardPinsService.logout;
  late final dioGetPin = _pinboardPinsService.dioGetPin;
  late final getRecentPins = _pinboardPinsService.getRecentPins;

  var count = 15;

  // pull in service methods view ViewModel
  // getters for pin and tag
  Future<List<PinboardPin>> get recent_pins =>
      _pinboardPinsService.getRecentPins(count: count);

  Future<List<Tag>> get tags => _tagsService.tags;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinboardPinsService];

  tryDelete(PinboardPin post) {}

  Future<void> startGet(String href, BuildContext context) async {
    PinboardPin pinboardPin = await dioGetPin(href);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PinSingleView(pin: pinboardPin)));
  }

  void addRecentPins(int i) {
    count += i;
    getRecentPins(count: count);
  }
}
