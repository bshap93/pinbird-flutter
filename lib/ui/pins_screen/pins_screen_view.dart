import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/new_pin_panel/new_pin_panel_view.dart';
import 'package:pinboard_clone/ui/pin_single/pin_single_view.dart';
import 'package:pinboard_clone/ui/pins_screen/pins_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pins_screen_viewmodel.dart';

class PinsScreenView extends StatelessWidget {
  const PinsScreenView({Key? key}) : super(key: key);

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
              return ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.horizontal_rule),
                  onPressed: () => model.removePin(pin_datum.id),
                ),
                title: Column(
                  children: [
                    // TextField(
                    //   // See above
                    //   controller: TextEditingController(text: pin.description),
                    //   onTap: () => {},
                    //   decoration: null,
                    //   focusNode: AlwaysDisabledFocusNode(),
                    //   // focusNode: model.getFocusNode(pin.id),
                    //   maxLines: null,
                    //   // onChanged: null,
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     decoration:
                    //         pin.wasRead ? TextDecoration.lineThrough : null,
                    //   ),
                    // ),
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
