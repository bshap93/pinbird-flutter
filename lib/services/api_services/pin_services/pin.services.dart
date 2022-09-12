import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:pinboard_clone/services/api_services/pinboard_api.services.dart';
import 'package:stacked/stacked.dart';

class PinService extends PinboardAPIService {
  // Local storage from Hive to match with remote data from Pinboard

  final _pins = ReactiveValue<List<PinboardPin>>(
    Hive.box('pinboard_pins')
        .get('pinboard_pins', defaultValue: []).cast<PinboardPin>(),
  );
  // to be called to change our state values
  void _saveToHive() =>
      Hive.box('pinboard_pins').put('pinboard_pins', _pins.value);

  // Composite Action Calls, invoking Dio API call methods

  Future<bool> removePin(String url) async {
    throw Exception(
        "Sorry, Pinboard doesn't support deleting pins by conventional means.");
  }

  // Dio API Calls
  // Deleting not allowed at the current time
  Future<void> dioDeletePin({required String url}) async {
    try {
      Response resp = await dioClient.delete(
          baseUrl + '/posts/delete?url=' + url + getAuthAppendage(apiToken));

      print(resp.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }

  Future<List<PinboardPin>> dioGetRecentPins() async {
    List<PinboardPin> results = <PinboardPin>[];
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response pinboardPinData = await dioClient
          .get(baseUrl + '/posts/recent' + getAuthAppendage(apiToken));
      print('Pinboard pins: ${pinboardPinData.data["posts"]}');
      for (var _pinboardPin in pinboardPinData.data["posts"]) {
        PinboardPin p = PinboardPin.fromJson(_pinboardPin);
        results.add(p);
      }
      notifyListeners();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return results;
  }
}
