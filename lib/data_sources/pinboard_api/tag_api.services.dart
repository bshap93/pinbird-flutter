import '../../models/tag/tag.dart';
import 'api.services.dart';
import 'package:dio/dio.dart';

class TagAPIService extends PinboardAPIV1Service {
  Future<List<Tag>> dioGetTags() async {
    List<Tag> results = <Tag>[];
    try {
      Response tagData = await dioClient
          .get(baseUrlV1 + '/tags/get' + getAuthAppendage(apiToken));

      print(tagData.data.toString());

      for (var _tag in tagData.data) {
        Tag p = Tag.fromJson(_tag);
        results.add(p);
      }
      notifyListeners();
    } on DioError catch (e) {
      logErrors(e);
    }
    // TODO empty placeholder return
    return results;
  }
}
