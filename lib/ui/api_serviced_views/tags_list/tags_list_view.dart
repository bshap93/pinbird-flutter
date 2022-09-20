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
      body: tagListFutureBuilder(model),
    );
  }

  tagListFutureBuilder(TagsListViewModel model) {
    return FutureBuilder(
      future: model.tags,
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

        return NotificationListener<ScrollEndNotification>(
          child: ListView(
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
          ),
          onNotification: (notification) {
            // 15 elements are about 920 pixels long
            // This varies slightly whether those pin elements have tags
            // so we err on the side of more page loads, which also improves ui.

            // NOTE the maximum recent pins the API will serve is 100...
            // When 10 pages load, there can be no more pages. At that point
            // a normal use case would be rather the search.
            // if (notification.metrics.pixels > (numPagesLoaded * 900)) {
            //   model.addRecentPins(15);
            //   // ignore: avoid_print
            //   numPagesLoaded += 1;
            //   print("$numPagesLoaded pages loaded");
            // }
            return true;
          },
        );
      },
    );
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
