import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class URLTextField extends StatelessWidget {
  const URLTextField(
      {Key? key, required Widget widget, required ReactiveViewModel model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        // TODO split URL bearing TextField into stateless Widget or function
        );
  }
}
