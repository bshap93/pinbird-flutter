import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../services/api_services/dio_client.dart';

class RecentPinsViewModel extends ReactiveViewModel {
  final _firstPinFocusNode = FocusNode();
  // pull in services via locator
  final _dioClient = locator<DioClient>();
  // pull in service methods view ViewModel
  // getters for pin and tag
  Future<List<PinboardPin>> get recent_pins => _dioClient.getRecentPosts();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_dioClient];
}
