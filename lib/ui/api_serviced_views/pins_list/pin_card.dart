import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/api_serviced_views/pins_list/pins_list_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/pinboard_pin/pinboard_pin.dart';
import '../../shared/formatter.dart';

class PinCard extends StatelessWidget {
  const PinCard({
    Key? key,
    required this.pin,
    required this.model,
    required this.descriptionController,
  }) : super(key: key);

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
                {
                  // ignore: deprecated_member_use
                  launch("https://www.google.com"),
                }
              else
                // ignore: deprecated_member_use
                {launch("https://${pin.href}")}
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
          Formatter.ifShowTags(pin.tags),
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
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
