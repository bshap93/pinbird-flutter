import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/tag/tag.dart';
import 'package:stacked/stacked.dart';

import 'tags_list_viewmodel.dart';

class TagsListView extends StatefulWidget {
  const TagsListView({super.key});

  @override
  State<TagsListView> createState() => _TagsListViewState();
}

class _TagsListViewState extends State<TagsListView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TagsListViewModel>.reactive(
        viewModelBuilder: () => TagsListViewModel(),
        builder: (context, model, _) {
          return tagsListScaffold("My Tags", model, context);
        });
  }

  Widget tagsListScaffold(
      String appBarTitle, TagsListViewModel model, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: <Widget>[],
      ),
    );
  }
}
