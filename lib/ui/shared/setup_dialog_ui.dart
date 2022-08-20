import 'package:flutter/cupertino.dart';
import 'package:pinboard_clone/enums/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        BasicDialog(request: request, completer: completer),
  };
}
