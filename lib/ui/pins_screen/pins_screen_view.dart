// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/new_pin_panel/new_pin_panel_view.dart';
import 'package:pinboard_clone/ui/pin_single/pin_single_view.dart';
import 'package:pinboard_clone/ui/pins_screen/pins_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pins_screen_viewmodel.dart';

class PinsScreenView extends StatefulWidget {
  const PinsScreenView({Key? key}) : super(key: key);

  @override
  State<PinsScreenView> createState() => _PinsScreenViewState();
}

class _PinsScreenViewState extends State<PinsScreenView> {
  Future<void> _tryDelete(String _id, PinsScreenViewModel model) async {
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
                model.removePin(_id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinsScreenViewModel>.reactive(
      viewModelBuilder: () => PinsScreenViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(title: const Text('Pin Bookmarks')),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            if (model.pin_data.isEmpty)
              Opacity(
                opacity: 0.5,
                child: Column(
                  children: const [
                    SizedBox(height: 64),
                    Icon(Icons.emoji_food_beverage_outlined, size: 48),
                    SizedBox(height: 16),
                    Text('No pins yet. Click + to add a new one.'),
                  ],
                ),
              ),
            ...model.pin_data.map((pin_datum) {
              return Card(
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.horizontal_rule),
                    // onPressed: () => model.removePin(pin_datum.id),
                    onPressed: () => _tryDelete(pin_datum.id, model),
                  ),
                  title: Column(
                    children: [
                      TextField(
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
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_right,
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PinSingleView(pin_datum: pin_datum))),
                  ),
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewPin(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _startAddNewPin(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewPinPanel(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
