import '../../models/tag/tag.dart';
import '../api/api.services.dart';
import 'package:dio/dio.dart';

class TagAPIService extends PinboardAPIService {
  List<Tag> results = <Tag>[];
  Future<List<Tag>> dioGetTags() async {
    try {
      Response resp = await dioClient
          .get(baseUrl + '/tags/get' + getAuthAppendage(apiToken));
    } on DioError catch (e) {
      logErrors(e);
    }
    // TODO empty placeholder return
    return [];
  }
}
