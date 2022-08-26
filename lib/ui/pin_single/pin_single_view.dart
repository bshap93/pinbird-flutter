import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/new_pin_panel/new_pin_panel_view.dart';
import 'package:pinboard_clone/ui/pin_single/pin_single_viewmodel.dart';
import 'package:pinboard_clone/ui/pins_screen/pins_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pins_screen/pins_screen_view.dart';

class PinSingleView extends StatelessWidget {
  const PinSingleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinSingleViewModel>.reactive(
        viewModelBuilder: () => PinSingleViewModel('FAKEID'),
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(title: const Text('Single Pin')),
            body: Card(
              child: Column(
                children: [
                  Text("This pin's URL:"),
                  TextField(
                    // See above
                    controller: TextEditingController(text: model.pin.url),
                    // ignore: deprecated_member_use
                    onTap: () => {
                      if (pin.url == null)
                        {
                          launch("https://www.google.com"),
                        }
                      else
                        {launch("https://" + pin.url)}
                    },
                    decoration: null,
                    focusNode: AlwaysDisabledFocusNode(),
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      decoration:
                          pin.wasRead ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            )));
  }
}
