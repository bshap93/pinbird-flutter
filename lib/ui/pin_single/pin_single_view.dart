// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pin_single/pin_single_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/pin_data.dart';
import '../pins_screen/pins_screen_view.dart';

class PinSingleView extends StatelessWidget {
  const PinSingleView({super.key, required this.pin_datum});

  final PinData pin_datum;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinSingleViewModel>.reactive(
        viewModelBuilder: () => PinSingleViewModel(pin_datum.id),
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(title: Text(pin_datum.description)),
            body: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      // See above
                      controller:
                          TextEditingController(text: pin_datum.description),
                      // ignore: deprecated_member_use
                      onTap: () => {},
                      decoration: null,
                      focusNode: AlwaysDisabledFocusNode(),
                      maxLines: null,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      // See above
                      controller: TextEditingController(text: pin_datum.url),
                      // ignore: deprecated_member_use
                      onTap: () => {
                        if (pin_datum.url == null)
                          {
                            launch("https://www.google.com"),
                          }
                        else
                          {launch("https://" + pin_datum.url)}
                      },
                      decoration: null,
                      focusNode: AlwaysDisabledFocusNode(),
                      maxLines: null,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        children: [
                          Icon(Icons.tag),
                          Text(pin_datum.tag.tag),
                          // TextField(
                          //   // See above
                          //   controller:
                          //       TextEditingController(text: pin_datum.tag.tag),
                          //   // ignore: deprecated_member_use
                          //   onTap: () => {
                          //     // Go to a tag view list
                          //   },
                          //   decoration: null,
                          //   focusNode: AlwaysDisabledFocusNode(),
                          //   maxLines: null,
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 20,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
