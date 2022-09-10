import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin.dart';
import 'package:pinboard_clone/services/api_services/pinboard_api.services.dart';
import 'package:stacked/stacked.dart';

class PinService extends PinboardAPIService {
  final _pins = ReactiveValue<List<PinboardPin>>(
    Hive.box('pinboard_pins')
        .get('pinboard_pins', defaultValue: []).cast<PinboardPin>(),
  );

  Future<List<PinboardPin>> getRecentPosts() async {
    // Perform GET request to the endpoint "/users/<id>"
    Response pinboardPinData = await dioClient
        .get(baseUrl + '/posts/recent' + getAuthAppendage(apiToken));

    List<PinboardPin> results = <PinboardPin>[];
    // Prints the raw data returned by the server
    print('Pinboard pins: ${pinboardPinData.data["posts"]}');

    // Parsing the raw JSON data to the User class
    for (var _pinboardPin in pinboardPinData.data["posts"]) {
      PinboardPin p = PinboardPin.fromJson(_pinboardPin);
      results.add(p);
    }

    notifyListeners();

    return results;
  }
}
