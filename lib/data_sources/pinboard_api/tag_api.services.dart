import 'login.services.dart';

import '../../models/tag/tag.dart';
import 'api.services.dart';
import 'package:dio/dio.dart';

class TagAPIService extends PinboardAPIV1Service {
  final loginService = LoginServices();

  void setToken(String token) {
    loginService.setApiToken(token);
  }

  Future<List<Tag>> dioGetTags() async {
    List<Tag> results = <Tag>[];
    try {
      // ignore: prefer_interpolation_to_compose_strings
      Response tagData = await dioClient.get(baseUrlV1 +
          '/tags/get' +
          loginService.getAuthAppendage(loginService.apiToken));

      print(tagData.data.toString());

      tagData.data.forEach((k, v) => results.add(Tag(tag: k, count: v)));

      notifyListeners();
    } on DioError catch (e) {
      logErrors(e);
    }
    // TODO empty placeholder return
    return results;
  }

  Future<List<String>> suggestTags(String url) async {
    List<String> results = <String>[];
    try {
      Response tagData = await dioClient
          .get(baseUrlV1 + '/posts/suggest' +
            loginService.getAuthAppendage(loginService.apiToken) +
            '&url=' + url);

      print(tagData.data.toString());
      // Below would give us results for popular but we ignore it for now.
      // final popular = tagData.data[0];

      // the second nested array holds recommendations, and is double nested for
      // whatever reason by the API (after indexing in at 1 there is a singleton
      // needing to be indexed at 'somestring'
      final _suggestedTags = tagData.data[1]['recommended'];

      for (var _tag in _suggestedTags) {
        results.add(_tag);
      }
      notifyListeners();
    } on DioError catch (e) {
      logErrors(e);
    }
    // TODO empty placeholder return
    return results;
  }
}
