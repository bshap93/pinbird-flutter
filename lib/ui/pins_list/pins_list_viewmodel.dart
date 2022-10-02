import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/pinboard_pin/pinboard_pin.dart';
import '../../services/tag.sercives.dart';
import '../pin_single/pin_single.dart';
import '../../app/locator.dart';
import '../../models/tag/tag.dart';
import '../../services/pin.services.dart';

class PinsListViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  // pull in services via locator
  final _pinboardPinsService = locator<PinService>();
  final _tagsService = locator<TagService>();
  late final logout = _pinboardPinsService.logout;
  late final dioGetPin = _pinboardPinsService.dioGetPin;
  late final getRecentPins = _pinboardPinsService.getRecentPins;
  late final setCurrentTag = _tagsService.setCurrentTag;
  late final loadInRecentPins = _pinboardPinsService.loadInRecentPins;
  late final emptyPinsHive = _pinboardPinsService.emptyHive;
  late final signalChange = _pinboardPinsService.signalChange;
  late final startCreatePin = _pinboardPinsService.startCreatePin;

  var count = 15;

  String? tagFilter = null;

  List<PinboardPin> get pins => _pinboardPinsService.pinboardPins;

  // pull in service methods view ViewModel
  // getters for pin and tag
  Future<List<PinboardPin>> recent_pins(Tag? tag) {
    return _pinboardPinsService.getRecentPins(count: count, myTag: tag);
  }

  List<Tag> get tags => _tagsService.tags;

  void changeToNewTag(Tag myTag) {
    setCurrentTag(myTag.tag);
    loadInRecentPins(15, myTag);
  }

  tryDelete(PinboardPin post) {}

  Future<void> startGet(String href, BuildContext context) async {
    PinboardPin pinboardPin = await dioGetPin(href);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PinSingleView(pin: pinboardPin)));
  }

  void addRecentPins(int i, myTag) {
    count += i;
    loadInRecentPins(count, myTag);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_pinboardPinsService, _tagsService];
}
