import 'package:pinboard_clone/services/reactive_services/tag.data.services.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/tag.dart';
import '../../models/post.dart';
import '../../services/reactive_services/post.services.dart';

class NewPinPanelViewModel extends ReactiveViewModel {
  final _pinDataService = locator<PostService>();
  final _tagDataService = locator<TagService>();
  late final updatePinContent = _pinDataService.updatePinDataContent;
  late final getNewestTag = _tagDataService.getNewestTag;

  final _tagService = locator<TagService>();
  late final newTag = _tagService.newTag;

  Tag get currentTag => _tagService.currentTag;

  List<Post> get pins => _pinDataService.posts;

  // return pin id
  String newPinDataWithId() {
    _pinDataService.newPost();
    // _firstPinFocusNode.requestFocus();
    String? _id = _pinDataService.newPostId();
    if (_id == null) {
      throw NullThrownError();
    } else {
      return _id;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_pinDataService];
}
