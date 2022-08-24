import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'new_pin_panel_viewmodel.dart';

class NewPinPanel extends StatefulWidget {
  NewPinPanel({Key? key}) : super(key: key);

  @override
  State<NewPinPanel> createState() => _NewPinPanelState();
}

class _NewPinPanelState extends State<NewPinPanel> {
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();

  void submitData(BuildContext ctx, NewPinPanelViewModel nppvm) {
    final enteredDescription = descriptionController.text;
    final eneteredURL = urlController.text;

    if (enteredDescription.isEmpty || eneteredURL.isEmpty) {
      return;
    }

    nppvm.updatePinContent(
      id: nppvm.newPinWithId(),
      url: eneteredURL,
      description: enteredDescription,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewPinPanelViewModel>.reactive(
        viewModelBuilder: () => NewPinPanelViewModel(),
        builder: (context, model, _) => Card(
            elevation: 5,
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration:
                          InputDecoration(labelText: 'Link Description'),
                      controller: descriptionController,
                      onSubmitted: (_) => submitData(context, model),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Link URL'),
                      controller: urlController,
                      onSubmitted: (_) => submitData(context, model),
                    ),
                    FlatButton(
                        textColor: Colors.white,
                        onPressed: () => submitData(context, model),
                        child: Text('Add Pin Link')),
                  ],
                ))));
  }
}
