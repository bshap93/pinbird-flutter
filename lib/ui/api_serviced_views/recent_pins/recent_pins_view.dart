import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/api_serviced_views/recent_pins/recent_pins_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/pinboard_pin/pinboard_pin.dart';
import '../../shared/formatter.dart';

// Line 53 and 90 have commented out yet important code.

class RecentPinsView extends StatefulWidget {
  const RecentPinsView({Key? key}) : super(key: key);

  @override
  State<RecentPinsView> createState() => _RecentPinsViewState();
}

class _RecentPinsViewState extends State<RecentPinsView> {
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

  // persist URL state across views
  List<PinboardPin> myRecentPosts = [];
  // Create a Picker object to filter by tags
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecentPinsViewModel>.reactive(
        viewModelBuilder: () => RecentPinsViewModel(),
        builder: (context, model, _) {
          // Tag noneTag = model.getTagByName("None");
          return Scaffold(
              drawer: Drawer(
                  child: ListView(padding: EdgeInsets.zero, children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                        color: ThemeData.dark().colorScheme.background),
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
              ])),
              appBar: AppBar(
                title: Text("Recent Pins"),
                actions: <Widget>[
                  // TODO
                ],
              ),
              body: FutureBuilder(
                  future: model.recent_pins,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PinboardPin>> snapshot) {
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

                    return ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      children: [
                        if (myRecentPosts!.isEmpty) _showEmptyPage(),
                        ...myRecentPosts.map((pin) {
                          TextEditingController description_controller =
                              TextEditingController(text: pin.description);
                          return Card(
                              child: ListTile(
                            title: Column(
                              children: [
                                TextField(
                                  // See above
                                  controller: description_controller,
                                  // ignore: deprecated_member_use
                                  onTap: () => {
                                    if (pin.href == null)
                                      {
                                        // ignore: deprecated_member_use
                                        launch("https://www.google.com"),
                                      }
                                    else
                                      // ignore: deprecated_member_use
                                      {launch("https://" + pin.href)}
                                  },
                                  decoration: null,
                                  focusNode: AlwaysDisabledFocusNode(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(2.0)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Created ${Formatter.formatDate(pin.time)}",
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                // don't waste space if there aren't tags
                                Formatter.ifShowTags(pin.tags),
                                Padding(padding: EdgeInsets.all(2.0)),
                              ],
                            ),
                            // ignore: prefer_const_constructors
                            trailing: IconButton(
                              // ignore: prefer_const_constructors
                              icon: Icon(
                                Icons.arrow_forward,
                              ),
                              onPressed: () =>
                                  model.startGet(pin.href, context),
                              // onPressed: () => Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => {},
                              //             // PinboardPinView(post.href)))),
                            ),
                          ));
                        })
                      ],
                    );
                  }));
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
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
