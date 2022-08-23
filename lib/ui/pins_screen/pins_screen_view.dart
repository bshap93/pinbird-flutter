import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pins_screen/pins_screen_viewmodel.dart';

import '../../models/pin.dart';
import 'pins_screen_viewmodel.dart';

class PinsScreenView extends StatefulWidget {
  const PinsScreenView({Key? key}) : super(key: key);

  @override
  State<PinsScreenView> createState() => _PinsScreenViewState();
}

class _PinsScreenViewState extends State<PinsScreenView> {
  late PinsScreenViewModel viewModel;

  _createNewPin() {
    setState(() {
      viewModel.newPin();
    });
  }

  _removePin(String id) {
    setState(() {
      viewModel.removePin(id);
    });
  }

  _toggleStatus(String id) {
    setState(() {
      viewModel.toggleStatus(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = PinsScreenViewModel();
    // return ViewModelBuilder<PinsScreenViewModel>.reactive(
    //   viewModelBuilder: () => PinsScreenViewModel(),
    //   builder: (context, model, _) => Scaffold(
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Stacked pins')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          if (viewModel.pins.isEmpty)
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
          ...viewModel.pins.map((pin) {
            return ListTile(
              leading: IconButton(
                icon: Icon(
                  pin.wasRead ? Icons.task_alt : Icons.circle_outlined,
                ),
                onPressed: () => _toggleStatus(pin.id),
              ),
              title: TextField(
                controller: TextEditingController(text: pin.url),
                decoration: null,
                focusNode: viewModel.getFocusNode(pin.id),
                maxLines: null,
                onChanged: (text) => viewModel.updatePinContent(pin.id, text),
                style: TextStyle(
                  fontSize: 20,
                  decoration: pin.wasRead ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.horizontal_rule),
                onPressed: () => _removePin(pin.id),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewPin,
        child: const Icon(Icons.add),
      ),
    );
  }
}
