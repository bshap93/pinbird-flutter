import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/tag/tag.dart';
import '../../../services/tag/tag.sercives.dart';
import '../../../services/pin/post.services.dart';

class TagPickerViewModel extends ReactiveViewModel {
  // pull in services via locator
  final _pinDataService = locator<PostService>();
  final _tagService = locator<TagService>();
  late final setCurrentTag = _tagService.setCurrentTag;

  // Getters
  List<Tag> get tags => _tagService.tags;
  Tag get currentTag => _tagService.currentTag;

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_pinDataService, _tagService];
}
