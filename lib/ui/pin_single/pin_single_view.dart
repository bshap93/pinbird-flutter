// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pin_single/pin_single_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/pin_data.dart';
import '../pins_screen/pins_screen_view.dart';

class PinSingleView extends StatefulWidget {
  const PinSingleView({super.key, required this.pin_datum});

  final PinData pin_datum;

  @override
  State<PinSingleView> createState() => _PinSingleViewState();
}

class _PinSingleViewState extends State<PinSingleView> {
  @override
  Widget build(BuildContext context) {
    FocusNode descriptionFocusNode = new FocusNode();
    FocusNode urlFocusNode = new FocusNode();

    return ViewModelBuilder<PinSingleViewModel>.reactive(
        viewModelBuilder: () => PinSingleViewModel(widget.pin_datum.id),
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              title: Text(widget.pin_datum.description),
              actions: <Widget>[
                IconButton(
                    onPressed: () => _tryDelete(widget.pin_datum.id, model),
                    icon: const Icon(Icons.delete_outline))
              ],
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: TextField(
                    // See above
                    controller: TextEditingController(
                        text: widget.pin_datum.description),
                    decoration: null,
                    focusNode: descriptionFocusNode,
                    maxLines: null,
                    onChanged: (text) => model.updatePinDataContent(
                      id: widget.pin_datum.id,
                      url: widget.pin_datum.url,
                      description: text,
                      tag: widget.pin_datum.tag,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    focusNode: model.getFocusNode(widget.pin_datum.id),
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(descriptionFocusNode);
                    },
                  ),
                ),
                ListTile(
                  title: TextField(
                    // See above
                    controller:
                        TextEditingController(text: widget.pin_datum.url),
                    // ignore: deprecated_member_use
                    onTap: () => {
                      if (widget.pin_datum.url == null)
                        {
                          launch("https://www.google.com"),
                        }
                      else
                        {launch("https://" + widget.pin_datum.url)}
                    },
                    decoration: null,
                    onChanged: (text) => model.updatePinDataContent(
                      id: widget.pin_datum.id,
                      url: text,
                      description: widget.pin_datum.description,
                      tag: widget.pin_datum.tag,
                    ),
                    focusNode: urlFocusNode,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    focusNode: model.getFocusNode(widget.pin_datum.id),
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
                          Text(widget.pin_datum.tag.tag),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  Future<void> _tryDelete(String id, PinSingleViewModel model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete this pin?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                model.removePin(widget.pin_datum.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
