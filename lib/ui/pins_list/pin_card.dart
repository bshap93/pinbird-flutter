// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pins_list/pins_list_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/pinboard_pin/pinboard_pin.dart';
import '../../models/tag/tag.dart';
import '../shared/formatter.dart';

// Callback for choosing a tag in the card
typedef TagCallback = void Function(Tag tag);

class PinCard extends StatelessWidget {
  const PinCard({
    Key? key,
    required this.onCurrentTagChanged,
    required this.pin,
    required this.model,
    required this.descriptionController,
  }) : super(key: key);

  final TagCallback onCurrentTagChanged;
  final TextEditingController descriptionController;
  final PinboardPin pin;
  final PinsListViewModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Column(
        children: [
          TextField(
            // within tile links themselves should not be scrollable
            scrollPhysics: const NeverScrollableScrollPhysics(),
            // See above
            controller: descriptionController,
            // ignore: deprecated_member_use
            onTap: () => {
              if (pin.href == null)
                launch("https://www.google.com")
              else
                launch(pin.href)
            },
            decoration: null,
            focusNode: AlwaysDisabledFocusNode(),
            maxLines: 2,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          const Padding(padding: EdgeInsets.all(2.0)),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ifShowTags(pin.tags),
            ],
          ),
          const Padding(padding: EdgeInsets.all(2.0)),
        ],
      ),
      // ignore: prefer_const_constructors
      trailing: IconButton(
        // ignore: prefer_const_constructors
        icon: Icon(
          Icons.arrow_forward,
        ),
        onPressed: () => model.startGet(pin.href, context),
      ),
    ));
  }

  Widget ifShowTags(String tags) {
    if (tags.isNotEmpty) {
      List<String> listOfTagStrings = tags.split(' ');
      return Wrap(
        // crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 5.0,
        children: [
          ...listOfTagStrings.map((tag) {
            return ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeData.dark().colorScheme.background),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  Tag? myTag = model.getTag(tag);
                  if (myTag != null) {
                    onCurrentTagChanged(myTag);
                  } else {
                    print("Tag not found");
                  }
                },
                child: Text(tag));
          }),
        ],
      );
    } else {
      return const Padding(padding: EdgeInsets.zero);
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
