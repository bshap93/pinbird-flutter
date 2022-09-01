import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:stacked/stacked.dart';

import '../../models/tag.dart';
import './tag_picker_viewmodel.dart';

class TagPicker extends StatelessWidget {
  const TagPicker({Key? key}) : super(key: key);

  List<String> getPickerData(List<Tag> tags) {
    List<String> result = <String>[];
    for (var tag in tags.reversed) {
      result.insert(0, tag.tag);
    }
    return result;
  }

  showPickerModal(BuildContext context, TagPickerViewModel model) {
    //
    new Picker(
        footer: Text("Choose a tag"),
        adapter:
            PickerDataAdapter<String>(pickerdata: getPickerData(model.tags)),
        changeToFirst: true,
        backgroundColor: Theme.of(context).primaryColor,
        textStyle: TextStyle(color: Colors.white),
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          String pickText = picker.adapter.text;
          // Remove bracket characters that Picker library adds for some reason
          pickText = pickText.substring(1, pickText.length - 1);
          print(pickText);
          model.setCurrentTag(pickText);
        }).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TagPickerViewModel>.reactive(
        viewModelBuilder: () => TagPickerViewModel(),
        builder: (context, model, _) => showPickerModal(context, model));
  }
}
