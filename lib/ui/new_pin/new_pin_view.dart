import 'package:flutter/material.dart';
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

  // Our form validation prevents accidental submission
  // of this empty string
  String pinUrl = "";
  String pinTitle = "";

  // These can be empty.
  String pinDescription = "";
  String pinTags = "";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NewPinViewModel(),
      builder: (context, NewPinViewModel model, _) => Scaffold(
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
                                  _formKey.currentState?.save();
                                  Map<String, dynamic> pinCreateData =
                                      <String, dynamic>{};
                                  pinCreateData["url"] = pinUrl;
                                  pinCreateData["title"] = pinTitle;
                                  pinCreateData["description"] = pinDescription;
                                  pinCreateData["tags"] = pinTags;
                                  pinCreateData["private"] = markedPrivate;
                                  pinCreateData["read_later"] = markedReadLater;

                                  final pin =
                                      model.processPinCreateData(pinCreateData);

                                  model.startCreatePin(pin).then((created) {
                                    if (created) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text('Success!')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text('Failure!')),
                                      );
                                    }
                                    Navigator.pop(context);
                                  });

                                  // Finish and pass off to VMod
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.amber,
                                        content: Text(
                                            'Processing your new pin now...')),
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
          initialValue: "https://",
          // It must exist due to the validation
          onSaved: (String? url) {
            pinUrl = url!;
          },
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
          onSaved: (String? title) {
            pinTitle = title!;
          },
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
          onSaved: (description) {
            if (description == null) {
              pinDescription = "";
            } else {
              pinDescription = description;
            }
          },
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
          onSaved: (tags) {
            if (tags == null) {
              pinTags = "";
            } else {
              pinTags = tags;
            }
          },
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
