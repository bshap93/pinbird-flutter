import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  var headers = {'Authorization': 'Bearer bshap93:0D30C0B39A9A25638BAE'};
  var request =
      http.Request('GET', Uri.parse('https://api.pinboard.in/v1/posts/recent'));
  request.bodyFields = {};
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }

  // // This example uses the Google Books API to search for books about http.
  // // https://developers.google.com/books/docs/overview
  // var url =
  //     Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

  // // Await the http get response, then decode the json-formatted response.
  // var response = await http.get(url);
  // if (response.statusCode == 200) {
  //   var jsonResponse =
  //       convert.jsonDecode(response.body) as Map<String, dynamic>;
  //   var itemCount = jsonResponse['totalItems'];
  //   print('Number of books about http: $itemCount.');
  // } else {
  //   print('Request failed with status: ${response.statusCode}.');
  // }
}
