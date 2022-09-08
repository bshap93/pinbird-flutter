import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pinboard_pins/recent_pins/recent_pins_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/pinboard_pin.dart';

class RecentPinsView extends StatefulWidget {
  const RecentPinsView({Key? key}) : super(key: key);

  @override
  State<RecentPinsView> createState() => _RecentPinsViewState();
}

class _RecentPinsViewState extends State<RecentPinsView> {
  // persist URL state across views
  FocusNode urlFocusNode = new FocusNode();
  // Create a Picker object to filter by tags

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecentPinsViewModel>.reactive(
      viewModelBuilder: () => RecentPinsViewModel(),
      builder: (context, model, _) {
        // Tag noneTag = model.getTagByName("None");
        List<PinboardPin> my_recent_pins =
            model.recent_pins as List<PinboardPin>;
        return Scaffold(
          appBar: AppBar(title: Text("Recent Pins")),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              if (my_recent_pins.isEmpty) _showEmptyPage(),
              ...my_recent_pins.map((recent_pin_datum) {
                TextEditingController _urlController =
                    TextEditingController(text: recent_pin_datum.href);
                return Card(
                  child: ListTile(
                    title: Column(
                      children: [
                        TextField(
                          // See above
                          controller: _urlController,
                          // ignore: deprecated_member_use
                          onTap: () => {
                            if (recent_pin_datum.href == null)
                              {
                                // ignore: deprecated_member_use
                                launch("https://www.google.com"),
                              }
                            else
                              // ignore: deprecated_member_use
                              {launch("https://" + recent_pin_datum.href)}
                          },
                          decoration: null,
                          focusNode: urlFocusNode,
                          maxLines: null,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    // trailing: IconButton(
                    //     icon: Icon(
                    //       Icons.arrow_forward,
                    //     ),
                    //     onPressed: () => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => PinSingleView(
                    //                 recent_pin_datum: recent_pin_datum,
                    //                 urlController: _urlController)))),
                  ),
                );
              }),
              // if ((pin_datum.tag.tag == "None") ||
              //     (pin_datum.tag.tag == model.currentTag.tag)) {
            ],
          ),
        );
      },
    );
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
