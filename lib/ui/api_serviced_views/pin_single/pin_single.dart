import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/pinboard_pin/pinboard_pin.dart';
import 'pin_single_viewmodel.dart';

class PinSingleView extends StatefulWidget {
  PinSingleView({super.key, required this.pin});

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
              title: Text(widget.pin.description),
              actions: <Widget>[],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [...createListTilesForProperties()],
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
