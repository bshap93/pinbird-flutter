import 'package:flutter/material.dart';

import 'new_pin_panel_viewmodel.dart';

class NewPinPanel extends StatefulWidget {
  NewPinPanel({Key? key}) : super(key: key);

  @override
  State<NewPinPanel> createState() => _NewPinPanelState();
}

class _NewPinPanelState extends State<NewPinPanel> {
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();

  void submitData() {
    final enteredDescription = descriptionController.text;
    final eneteredURL = urlController.text;

    if (enteredDescription.isEmpty || eneteredURL.isEmpty) {
      return;
    }

    // _createNewPin();
    // String specificId = widget.viewModel.pins[0].id;

    // id 7494

    // widget.viewModel.updatePinContent(specificId, eneteredURL);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Link Description'),
                  controller: descriptionController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Link URL'),
                  controller: urlController,
                  onSubmitted: (_) => submitData(),
                ),
                FlatButton(
                    textColor: Colors.purple,
                    onPressed: submitData,
                    child: Text('Add Pin Link')),
              ],
            )));
  }
}
