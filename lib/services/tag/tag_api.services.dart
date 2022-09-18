import '../../models/tag/tag.dart';
import '../api/api.services.dart';
import 'package:dio/dio.dart';

class TagAPIService extends PinboardAPIService {
  List<Tag> results = <Tag>[];
  Future<List<Tag>> dioGetTags() async {
    try {
      Response tagData = await dioClient
          .get(baseUrl + '/tags/get' + getAuthAppendage(apiToken));

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
    return [];
  }
}
