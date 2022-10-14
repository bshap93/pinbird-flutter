import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../data_sources/pinboard_api_services/login.services.dart';
import '../../models/pinboard_pin/pinboard_pin.dart';
import '../../domain_services/tag.sercives.dart';
import '../pin_single/pin_single.dart';
import '../../app/locator.dart';
import '../../models/tag/tag.dart';
import '../../domain_services/pin.services.dart';

class PinsListViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  // pull in services via locator
  final _pinboardPinsService = locator<PinService>();
  final _tagsService = locator<TagService>();
  final _loginService = locator<LoginServices>();
  late final logout = _loginService.logout;
  late final dioGetPin = _pinboardPinsService.startGetPin;
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
  // TODO clean this up
  Future<List<PinboardPin>> recent_pins(Tag? tag) {
    return _pinboardPinsService.startGetRecentPins(count: count, myTag: tag);
  }

  List<Tag> get tags => _tagsService.tags;

  Tag? getTag(String tagId) {
    final myTags = this.tags.where((tag) => tag.tag == tagId);
    if (myTags.isNotEmpty) {
      return myTags.first;
    } else {
      return null;
    }
  }

  void changeToNewTag(Tag myTag) {
    setCurrentTag(myTag.tag);
    loadInRecentPins(15, myTag);
  }

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
