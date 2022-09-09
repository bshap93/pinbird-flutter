import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pinboard_pins/recent_pins/recent_pins_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/pinboard_pin.dart';

// Line 53 and 90 have commented out yet important code.

class RecentPinsView extends StatefulWidget {
  const RecentPinsView({Key? key}) : super(key: key);

  @override
  State<RecentPinsView> createState() => _RecentPinsViewState();
}

class _RecentPinsViewState extends State<RecentPinsView> {
  // persist URL state across views
  List<PinboardPin> my_recent_posts = [];
  // Create a Picker object to filter by tags

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecentPinsViewModel>.reactive(
        viewModelBuilder: () => RecentPinsViewModel(),
        builder: (context, model, _) {
          // Tag noneTag = model.getTagByName("None");
          return Scaffold(
              appBar: AppBar(title: Text("Recent Pins")),
              body: FutureBuilder(
                  future: model.recent_pins,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PinboardPin>> snapshot) {
                    if (!snapshot.hasData) {
                      // while data is loading:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      // data loaded:
                      my_recent_posts = snapshot.data!;
                      return ListView(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        children: [
                          if (my_recent_posts.isEmpty) _showEmptyPage(),
                          ...my_recent_posts.map((post) {
                            TextEditingController _description_controller =
                                TextEditingController(text: post.description);
                            return Card(
                              child: ListTile(
                                leading: IconButton(
                                  icon:
                                      const Icon(Icons.delete_outline_outlined),
                                  onPressed: () =>
                                      {}, // _tryDelete(post.id, model),
                                ),
                                title: Column(
                                  children: [
                                    TextField(
                                      // See above
                                      controller: _description_controller,
                                      // ignore: deprecated_member_use
                                      onTap: () => {
                                        if (post.href == null)
                                          {
                                            // ignore: deprecated_member_use
                                            launch("https://www.google.com"),
                                          }
                                        else
                                          // ignore: deprecated_member_use
                                          {launch("https://" + post.href)}
                                      },
                                      decoration: null,
                                      focusNode: AlwaysDisabledFocusNode(),
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    ),
                                    // See below
                                    onPressed: () => {}
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //         PinSingleView(
                                    //             post: post,
                                    //             urlController: _description_controller)
                                    //             )
                                    //             ),
                                    ),
                              ),
                            );
                          }),
                        ],
                      );
                    }
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
