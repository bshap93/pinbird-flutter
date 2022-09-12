import 'package:pinboard_clone/services/local_services/tag.data.services.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/tag/tag.dart';
import '../../../models/post/post.dart';
import '../../../services/local_services/post.services.dart';

class NewPinPanelViewModel extends ReactiveViewModel {
  final _postService = locator<PostService>();
  final _tagDataService = locator<TagService>();
  late final updatePinContent = _postService.updatePinDataContent;
  late final getNewestTag = _tagDataService.getNewestTag;

  final _tagService = locator<TagService>();
  late final newTag = _tagService.newTag;

  Tag get currentTag => _tagService.currentTag;

  List<Post> get pins => _postService.posts;

  // return pin id
  String newPostWithId() {
    _postService.newPost();
    // _firstPinFocusNode.requestFocus();
    String? _id = _postService.newPostId();
    if (_id == null) {
      throw NullThrownError();
    } else {
      return _id;
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_postService];
}
