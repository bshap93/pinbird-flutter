import 'package:pinboard_clone/services/tag/tag.sercives.dart';
import 'package:pinboard_clone/services/tag/tag_api.services.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/tag/tag.dart';

class TagsListViewModel extends ReactiveViewModel {
  final _tagsService = locator<TagService>();
  final _tagAPIService = locator<TagAPIService>();

  late final setCurrentTag = _tagsService.setCurrentTag;

  List<Tag> get tags => _tagsService.tags;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_tagsService];
}
