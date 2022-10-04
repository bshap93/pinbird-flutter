import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../services/pin.services.dart';

class NewPinViewModel extends ReactiveViewModel {
  final _pinService = locator<PinService>();
  late final startCreatePin = _pinService.startCreatePin;

  NewPinViewModel();

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
    }

    if (data["read_later"]) {
      newPin.toread = "yes";
    }

    return newPin;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinService];
}
