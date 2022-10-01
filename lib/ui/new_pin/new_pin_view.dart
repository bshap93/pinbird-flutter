import 'package:flutter/material.dart';
import 'package:pinboard_clone/models/pinboard_pin/pinboard_pin.dart';
import 'package:stacked/stacked.dart';

import 'new_pin_viewmodel.dart';

class NewPinView extends StatefulWidget {
  const NewPinView({super.key});

  @override
  State<NewPinView> createState() => _NewPinViewState();
}

class _NewPinViewState extends State<NewPinView> {
  final _formKey = GlobalKey<FormState>();

  bool markedPrivate = false;
  bool markedReadLater = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NewPinViewModel(),
      builder: (context, model, _) => Scaffold(
          appBar:
              AppBar(title: const Text('Create New Pin'), actions: const []),
          body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ...formFields,
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Get the form data and consolidate it into an object
                                  // PinboardPin buildPin = Pin

                                  // Finish and pass off to VMod
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Now hook this up to the API')),
                                  );
                                }
                              },
                              child: const Text('Submit')),
                        ],
                      ),
                    )),
          )),
    );
  }

  get formFields {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your Pin\'s URL',
          ),
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !Uri.parse(value).isAbsolute) {
              return 'Please enter a valid URL.';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your Pin\'s Name',
          ),
          validator: (value) {
            if (value == null) {
              return 'Please enter a name for your pin.';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a Description of your pin',
          ),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 20,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter tags for your pin (separate their names by space)',
          ),
          minLines: 1,
          maxLines: 10,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text('Private?'),
            Checkbox(
                value: markedPrivate,
                onChanged: (value) {
                  setState(() {
                    markedPrivate = !markedPrivate;
                  });
                }),
            const Text('Read Later?'),
            Checkbox(
                value: markedReadLater,
                onChanged: (value) {
                  setState(() {
                    markedReadLater = !markedReadLater;
                  });
                }),
          ],
        ),
      )
    ];
  }
}
