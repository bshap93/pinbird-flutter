import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pins_screen/pins_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'single_pin_viewmodel.dart';

class SinglePinView extends StatelessWidget {
  const SinglePinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinsScreenViewModel>.reactive(
      viewModelBuilder: () => PinsScreenViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(title: const Text('Flutter Stacked pins')),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            if (model.pins.isEmpty)
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
            ...model.pins.map((pin) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    pin.wasRead ? Icons.task_alt : Icons.circle_outlined,
                  ),
                  onPressed: () => model.toggleStatus(pin.id),
                ),
                title: TextField(
                  controller: TextEditingController(text: pin.url),
                  decoration: null,
                  focusNode: model.getFocusNode(pin.id),
                  maxLines: null,
                  onChanged: (text) => model.updatePinContent(pin.id, text),
                  style: TextStyle(
                    fontSize: 20,
                    decoration: pin.wasRead ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.horizontal_rule),
                  onPressed: () => model.removePin(pin.id),
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.newPin,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
