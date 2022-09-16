import 'package:stacked/stacked.dart';

import '../../models/tag/tag.dart';

class Defaults {
  static Tag noneTag = Tag(count: 0);
}

// think of this class as part of Defaults type
class NoneViewModel extends ReactiveViewModel {
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
