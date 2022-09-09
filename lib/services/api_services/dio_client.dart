import 'package:dio/dio.dart';
import 'package:pinboard_clone/models/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

class PinboardPinsService with ReactiveServiceMixin {
  final Dio _dioClient = Dio();

  final _baseUrl = 'https://api.pinboard.in/v1';

  // will not be hardcoded in any push
  static const _apiToken = 'bshap93:0D30C0B39A9A25638BAE';

  final _authAppendage = '?auth_token=' + _apiToken + "&format=json";

  //

  Future<List<PinboardPin>> getRecentPosts() async {
    // Perform GET request to the endpoint "/users/<id>"
    Response pinboardPinData =
        await _dioClient.get(_baseUrl + '/posts/recent' + _authAppendage);

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
