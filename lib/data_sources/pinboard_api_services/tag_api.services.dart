import 'login.services.dart';

import '../../models/tag/tag.dart';
import 'api.services.dart';
import 'package:dio/dio.dart';

class TagAPIService extends PinboardAPIV1Service {
  final loginService = LoginServices();

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

  // Future<List<Tag>> dioGetTags() async {
  //   List<Tag> results = <Tag>[];
  //   try {
  //     Response tagData = await dioClient
  //         .get(baseUrlV1 + '/tags/get' + getAuthAppendage(apiToken));

  //     print(tagData.data.toString());

  //     for (var _tag in tagData.data) {
  //       Tag p = Tag.fromJson(_tag);
  //       results.add(p);
  //     }
  //     notifyListeners();
  //   } on DioError catch (e) {
  //     logErrors(e);
  //   }
  //   // TODO empty placeholder return
  //   return results;
  // }
}
