import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/tag_picker/tag_picker.dart';
import 'package:pinboard_clone/ui/tag_picker/tag_picker_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/tag.dart';
import 'pins_screen_viewmodel.dart';

// Local lib imports
import '../new_pin_panel/new_pin_panel_view.dart';
import '../pin_single/pin_single_view.dart';
import './pins_screen_viewmodel.dart';

class PinsScreenView extends StatefulWidget {
  const PinsScreenView({Key? key}) : super(key: key);

  @override
  State<PinsScreenView> createState() => _PinsScreenViewState();
}

class _PinsScreenViewState extends State<PinsScreenView> {
  // persist URL state across views
  FocusNode urlFocusNode = new FocusNode();
  // Create a Picker object to filter by tags
  TagPickerViewModel tpvm = new TagPickerViewModel();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinsScreenViewModel>.reactive(
      viewModelBuilder: () => PinsScreenViewModel(),
      builder: (context, model, _) {
        Tag noneTag = model.getTagByName("None");
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                onPressed: () => {TagPicker().showPickerModal(context, tpvm)},
                icon: Icon(Icons.tag_rounded),
              ),
              title: (model.currentTag.tag == "None")
                  ? const Text('All Pins')
                  : Text(model.currentTag.tag)),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              if (model.posts.isEmpty) _showEmptyPage(),
              ...model.posts
                  .where((pin_datum) =>
                      pin_datum.tag.tag == model.currentTag.tag ||
                      model.currentTag.tag == "None")
                  .map((pin_datum) {
                TextEditingController _urlController =
                    TextEditingController(text: pin_datum.url);
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.delete_outline_outlined),
                      // onPressed: () => model.removePin(pin_datum.id),
                      onPressed: () => _tryDelete(pin_datum.id, model),
                    ),
                    title: Column(
                      children: [
                        TextField(
                          // See above
                          controller: _urlController,
                          // ignore: deprecated_member_use
                          onTap: () => {
                            if (pin_datum.url == null)
                              {
                                // ignore: deprecated_member_use
                                launch("https://www.google.com"),
                              }
                            else
                              // ignore: deprecated_member_use
                              {launch("https://" + pin_datum.url)}
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
                    trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PinSingleView(
                                    pin_datum: pin_datum,
                                    urlController: _urlController)))),
                  ),
                );
              }),
              // if ((pin_datum.tag.tag == "None") ||
              //     (pin_datum.tag.tag == model.currentTag.tag)) {
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _startAddNewPin(context);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
  // End of build method. Below are the other methods

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
    ).then((value) => null);
  }

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
