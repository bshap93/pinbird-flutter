import 'package:stacked/stacked.dart';

import '../../models/post/post.dart';
import '../../models/tag/tag.dart';

class Defaults {
  static Tag noneTag = Tag();

  static Post nonePost = Post(id: "None", description: "None", tag: noneTag);
}

// think of this class as part of Defaults type
class NoneViewModel extends ReactiveViewModel {
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
