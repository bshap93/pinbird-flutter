// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/tag/tag.dart';
import '../../shared/dialogs.dart';
import 'new_pin_panel_viewmodel.dart';

class NewPinPanel extends StatefulWidget {
  NewPinPanel({Key? key}) : super(key: key);

  @override
  State<NewPinPanel> createState() => _NewPinPanelState();
}

class _NewPinPanelState extends State<NewPinPanel> {
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();
  final tagController = TextEditingController();

  void submitData(BuildContext ctx, NewPinPanelViewModel nppvm) {
    final enteredDescription = descriptionController.text;
    final eneteredURL = urlController.text;
    final enteredTagStr = tagController.text;

    final createNotification = SnackBar(
      content: Text(
          "Use the right arrow to view an individual pin or the # symbol to filter  by tags."),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    );

    if (eneteredURL.isEmpty) {
      return;
    }

    nppvm.newTag(enteredTagStr);
    Tag enteredTag = nppvm.getNewestTag();
    final String newId = nppvm.newPostWithId();

    nppvm.updatePinContent(
      id: newId,
      url: eneteredURL,
      description: enteredDescription,
      tag: enteredTag,
    );

    Navigator.of(context).pop();
    int count = nppvm.pins.length;
    if (count < 2) {
      ScaffoldMessenger.of(context).showSnackBar(createNotification);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewPinPanelViewModel>.reactive(
        viewModelBuilder: () => NewPinPanelViewModel(),
        builder: (context, model, _) {
          if (model.currentTag.tag != "None") {
            tagController.text = model.currentTag.tag;
          }
          final ButtonStyle _style = ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20, color: Colors.white));
          return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Link Description'),
                    controller: descriptionController,
                    onSubmitted: (_) => submitData(context, model),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Link URL'),
                    controller: urlController,
                    onSubmitted: (_) => submitData(context, model),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Add a tag'),
                    controller: tagController,
                    onSubmitted: (_) => submitData(context, model),
                  ),
                  ElevatedButton(
                      style: _style,
                      onPressed: () {
                        if (urlController.text.isEmpty) {
                          Dialogs.showNoURLDialog(context);
                        } else {
                          submitData(context, model);
                        }
                      },
                      child: Text('Add Pin Link')),
                ],
              ));
        });
  }
}
