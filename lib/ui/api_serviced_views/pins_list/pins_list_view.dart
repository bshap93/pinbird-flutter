import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/shared/styles.dart';
import '../../../models/tag/tag.dart';
import 'pin_card.dart';
import '../../shared/empty_page.dart';
import 'pins_list_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../../models/pinboard_pin/pinboard_pin.dart';
import '../../../main.dart';

class PinsListView extends StatefulWidget {
  const PinsListView({Key? key}) : super(key: key);

  @override
  State<PinsListView> createState() => _PinsListViewState();
}

class _PinsListViewState extends State<PinsListView> {
  // persist URL state across views
  List<PinboardPin> myRecentPosts = [];
  int numPagesLoaded = 1;
  Tag? currentTag = null;
  // Create a Picker object to filter by tags
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinsListViewModel>.reactive(
        viewModelBuilder: () => PinsListViewModel(),
        builder: (context, model, _) {
          // Tag noneTag = model.getTagByName("None");
          return pinsListScaffold("Recent Pins", model, context);
        });
  }

  Scaffold pinsListScaffold(
      String title, PinsListViewModel model, BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(model, context),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[],
      ),
      body: pinsListFutureBuilder(model),
    );
  }

  FutureBuilder<List<PinboardPin>> pinsListFutureBuilder(
      PinsListViewModel model) {
    return FutureBuilder(
        future: model.recent_pins(currentTag),
        builder:
            (BuildContext context, AsyncSnapshot<List<PinboardPin>> snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            // ignore: prefer_const_constructors
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return _getPinsListMessage(snapshot.error.toString());
          }
          // data loaded:
          var myRecentPosts = snapshot.data;

          // ignore: prefer_is_empty
          if (myRecentPosts?.length == 0) {
            return _getPinsListMessage(
                'No data found for your account. Add something and check back.');
          }

          return NotificationListener<ScrollEndNotification>(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                if (myRecentPosts!.isEmpty) EmptyPage.showEmptyPinPage(),
                ...myRecentPosts.map((pin) {
                  TextEditingController descriptionController =
                      TextEditingController(text: pin.description);
                  return PinCard(
                      pin: pin,
                      model: model,
                      descriptionController: descriptionController);
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
              if (notification.metrics.pixels > (numPagesLoaded * 700)) {
                model.addRecentPins(15, null);
                // ignore: avoid_print
                numPagesLoaded += 1;
                print("$numPagesLoaded pages loaded");
              }
              return true;
            },
          );
        });
  }

  Drawer mainDrawer(PinsListViewModel model, BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
          decoration:
              BoxDecoration(color: ThemeData.dark().colorScheme.background),
          child: const Text('Pinboard Pages')),
      ListTile(
        title: const Text('Logout'),
        onTap: () {
          MyApp.restartApp(context);
          model.logout();
          // Exit drawer
          Navigator.pop(context);
          // Pop back to login page
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: const Text("Choose a Tag"),
        onTap: () {
          Navigator.pop(context);
          tagListModalSheet(context, model);
        },
      )
    ]));
  }

  Future<dynamic> tagListModalSheet(
      BuildContext context, PinsListViewModel model) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          List<Tag> filter = [];
          filter.addAll(model.tags);
          return Container(
              height: 350,
              color: ThemeData.dark().colorScheme.background,
              child: ListView(
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     // within tile links themselves should not be scrollable
                  //     scrollPhysics: const NeverScrollableScrollPhysics(),
                  //     // See above
                  //     onChanged: (newValue) => setState(() {
                  //       filter.retainWhere((tag) {
                  //         return tag.tag
                  //             .toLowerCase()
                  //             .startsWith(newValue.toLowerCase());
                  //       });
                  //     }),
                  //     decoration: const InputDecoration(
                  //         hintStyle:
                  //             TextStyle(color: Colors.white, fontSize: 16),
                  //         hintText: 'Search for a tag...'),
                  //     focusNode: null,
                  //     maxLines: 1,
                  //     style: const TextStyle(
                  //       color: Colors.blue,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                  ...filter.map((tag) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            ThemeData.dark().colorScheme.surface),
                      ),
                      onPressed: () {
                        model.setCurrentTag(tag.tag);
                        currentTag = tag;
                        model.emptyPinsHive();
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          tag.tag,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  })
                ],
              ));
        });
  }

  // End of build method. Below are the other methods

  _showEmptyPage() {
    return Opacity(
      opacity: 0.5,
      child: Column(
        children: const [
          SizedBox(height: 64),
          Icon(Icons.emoji_food_beverage_outlined, size: 48),
          SizedBox(height: 16),
          Text(
            'No pins yet. Click + below to add a new one. \n\n Click # above to select a tag.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _getPinsListMessage(String message) {
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
            child: Text("Return to Login")),
      ],
    );
  }
}
