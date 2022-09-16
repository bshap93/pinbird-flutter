import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../models/pinboard_pin/pinboard_pin.dart';
import '../../shared/formatter.dart';
import 'pin_single_viewmodel.dart';

class PinSingleView extends StatefulWidget {
  const PinSingleView({super.key, required this.pin});

  final PinboardPin pin;

  @override
  State<PinSingleView> createState() => _PinSingleViewState();
}

class _PinSingleViewState extends State<PinSingleView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinViewModel>.reactive(
        viewModelBuilder: () => PinViewModel(widget.pin.href),
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              title: Text(widget.pin.time),
              actions: <Widget>[],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                ListTile(
                  title: Text(widget.pin.description),
                ),
                ListTile(
                  title: TextField(
                    // See above
                    controller: TextEditingController(
                        // Concatenated string ->
                        text: Formatter.formatDateTime(widget.pin.time)),
                    focusNode: AlwaysDisabledFocusNode(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    focusNode: AlwaysDisabledFocusNode(),
                    icon: const Icon(Icons.date_range),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading: const Text("Tags: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  title: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.tag),
                          Text(widget.pin.tags),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  List<Widget> createListTilesForProperties() {
    final mapOfProps = widget.pin.toJson();
    final listTileList = <ListTile>[];

    for (var key in mapOfProps.keys) {
      listTileList.add(ListTile(title: Text("$key equals ${mapOfProps[key]}")));
    }
    return listTileList;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
