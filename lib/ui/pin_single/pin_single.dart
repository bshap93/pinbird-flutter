import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../models/pinboard_pin/pinboard_pin.dart';
import '../../pkg/flutter_easy_autocomplete/lib/easy_autocomplete.dart';
import '../shared/formatter.dart';
import 'pin_single_viewmodel.dart';

class PinSingleView extends StatefulWidget {
  const PinSingleView({super.key, required this.pin});

  final PinboardPin pin;

  @override
  State<PinSingleView> createState() => _PinSingleViewState();
}

class _PinSingleViewState extends State<PinSingleView> {
  final _formKey = GlobalKey<FormState>();

  late String pinUrl;

  late String pinTitle;

  late String pinDescription;

  late String pinTags;

  var markedPrivate;

  var markedReadLater;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PinViewModel>.reactive(
        viewModelBuilder: () {
          pinUrl = widget.pin.href;
          pinTitle = widget.pin.description;
          pinDescription = widget.pin.extended;
          pinTags = widget.pin.tags;
          markedPrivate = (widget.pin.shared == "yes") ? false : true;
          markedReadLater = (widget.pin.toread == "no") ? false : true;
          return PinViewModel(widget.pin.href);
        },
        builder: (context, PinViewModel model, _) => Scaffold(
            appBar: AppBar(
              title: Text(widget.pin.description),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    model.startDeletePin(widget.pin.href);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.amber,
                        content: Text('Deleted your pin.')));
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Builder(
                  builder: (context) => Form(
                        key: _formKey,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          children: [
                            ListTile(
                              title: Text(
                                  "Created at: ${Formatter.formatDateTime(widget.pin.time)}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                initialValue: pinUrl,
                                // It must exist due to the validation
                                onSaved: (String? url) {
                                  pinUrl = url!;
                                },
                                decoration: const InputDecoration(
                                  label: Text("URL"),
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
                                initialValue: pinTitle,
                                onSaved: (String? title) {
                                  pinTitle = title!;
                                },
                                decoration: const InputDecoration(
                                  label: Text("Title:"),
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your Pin\'s Name',
                                ),
                                maxLines: 3,
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
                                initialValue: pinDescription,
                                onChanged: (description) {
                                  if (description == null) {
                                    pinDescription = "";
                                  } else {
                                    pinDescription = description;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Description:"),
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
                              child: EasyAutocomplete(
                                suggestions: model.strTags(),
                                initialValue: pinTags,
                                onSaved: (tags) {
                                  if (tags == "" || tags == null) {
                                    pinTags = "";
                                  } else {
                                    pinTags = tags;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Tags:"),
                                  hintText:
                                      'Enter tags for your pin (separate their names by space)',
                                ),
                                // minLines: 1,
                                // maxLines: 10,
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
                            ),
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
                                    pinCreateData["description"] =
                                        pinDescription;
                                    pinCreateData["tags"] = pinTags;
                                    pinCreateData["private"] = markedPrivate;
                                    pinCreateData["read_later"] =
                                        markedReadLater;

                                    pinCreateData["meta"] = widget.pin.meta;
                                    pinCreateData["hash"] = widget.pin.hash;
                                    pinCreateData["time"] = widget.pin.time;

                                    final pin =
                                        model.processPinUpdate(pinCreateData);

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
