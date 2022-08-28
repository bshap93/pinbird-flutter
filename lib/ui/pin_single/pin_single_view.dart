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
    FocusNode descriptionFocusNode = new FocusNode();
    FocusNode urlFocusNode = new FocusNode();

    return ViewModelBuilder<PinSingleViewModel>.reactive(
        viewModelBuilder: () => PinSingleViewModel(pin_datum.id),
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              title: Text(pin_datum.description),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: TextField(
                    // See above
                    controller:
                        TextEditingController(text: pin_datum.description),
                    decoration: null,
                    focusNode: descriptionFocusNode,
                    maxLines: null,
                    onChanged: (text) => model.updatePinDataContent(
                      id: pin_datum.id,
                      url: pin_datum.url,
                      description: text,
                      tag: pin_datum.tag,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    focusNode: model.getFocusNode(pin_datum.id),
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(descriptionFocusNode);
                    },
                  ),
                ),
                ListTile(
                  title: TextField(
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
                    onChanged: (text) => model.updatePinDataContent(
                      id: pin_datum.id,
                      url: text,
                      description: pin_datum.description,
                      tag: pin_datum.tag,
                    ),
                    focusNode: urlFocusNode,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    focusNode: model.getFocusNode(pin_datum.id),
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(urlFocusNode);
                    },
                  ),
                ),
                ListTile(
                  leading: Text("Tags: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  title: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.tag),
                          Text(pin_datum.tag.tag),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
