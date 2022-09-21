import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/tag/tag.dart';
import 'package:pinboard_clone/ui/shared/empty_page.dart';
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
        body: FutureBuilder(
          future: model.loadThenGetAllTags(),
          builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return _getTagsListMessage(snapshot.error.toString());
            }

            var myRecentTags = snapshot.data;

            if (myRecentTags?.length == 0) {
              return _getTagsListMessage(
                  'No data found for your account. Add something and check back.');
            }

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                if (myRecentTags!.isEmpty) EmptyPage.showEmptyTagPage(),
                ...myRecentTags.map((tag) {
                  TextEditingController descriptionController =
                      TextEditingController(text: tag.tag);
                  return Card(
                    child: ListTile(
                      title: Column(children: [
                        Text(tag.tag),
                      ]),
                    ),
                  );
                })
              ],
            );
          },
        ));
  }

  _getTagsListMessage(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          message,
          textAlign: TextAlign.center,
          style:
              TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[500]),
        )),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Return to Pins List")),
      ],
    );
  }
}

class TagCard {
  final String tag;
  final int count;
  TagCard({required this.tag, required this.count});

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(children: [
          Text(tag),
        ]),
      ),
    );
  }
}
