import 'package:flutter/material.dart';
import 'pin_card.dart';
import 'pins_list_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../../models/pinboard_pin/pinboard_pin.dart';

class PinsListView extends StatefulWidget {
  const PinsListView({Key? key}) : super(key: key);

  @override
  State<PinsListView> createState() => _PinsListViewState();
}

class _PinsListViewState extends State<PinsListView> {
  // persist URL state across views
  List<PinboardPin> myRecentPosts = [];
  int numPagesLoaded = 1;
  // Create a Picker object to filter by tags
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinsListViewModel>.reactive(
        viewModelBuilder: () => PinsListViewModel(),
        builder: (context, model, _) {
          // Tag noneTag = model.getTagByName("None");
          return listScaffold("Recent Pins", model, context);
        });
  }

  Scaffold listScaffold(
      String title, PinsListViewModel model, BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(model, context),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
              onPressed: () => dispalyTags(model), icon: Icon(Icons.apple)),
        ],
      ),
      body: pinsListFutureBuilder(model),
    );
  }

  FutureBuilder<List<PinboardPin>> pinsListFutureBuilder(
      PinsListViewModel model) {
    return FutureBuilder(
        future: model.recent_pins,
        builder:
            (BuildContext context, AsyncSnapshot<List<PinboardPin>> snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            // ignore: prefer_const_constructors
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return _getInformationMessage(snapshot.error.toString());
          }
          // data loaded:
          var myRecentPosts = snapshot.data;

          // ignore: prefer_is_empty
          if (myRecentPosts?.length == 0) {
            return _getInformationMessage(
                'No data found for your account. Add something and check back.');
          }

          return NotificationListener<ScrollEndNotification>(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                if (myRecentPosts!.isEmpty) _showEmptyPage(),
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
              if (notification.metrics.pixels > (numPagesLoaded * 900)) {
                model.addRecentPins(15);
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
          model.logout();
          // Exit drawer
          Navigator.pop(context);
          // Pop back to login page
          Navigator.pop(context);
        },
      ),
      ListTile(
          // TODO dropdown
          // DropdownButton<String>(value: "Choose a Tag", onChanged: (_) => {}),
          ),
    ]));
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

  Widget _getInformationMessage(String message) {
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

  dispalyTags(PinsListViewModel model) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return FutureBuilder(
              future: model.tags,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return _getInformationMessage(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    return Container(
                        color: Theme.of(context).backgroundColor,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(snapshot.data.toString(),
                                style: const TextStyle(
                                    color: Colors.cyan, fontSize: 36))
                          ],
                        )));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }));
        });
  }
}
