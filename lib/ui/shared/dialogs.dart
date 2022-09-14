import 'package:flutter/material.dart';

class Dialogs {
  static void ShowLoginHelp(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Finding your Pinboard API Key'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('1: Log in to Pinboard.in '),
                Text('Please add a URL or path for your pin.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showNoURLDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No URL'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your bookmark pin has no URL.'),
                Text('Please add a URL or path for your pin.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showNoInputDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No URL'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your bookmark pin has no URL.'),
                Text('Please add a URL or path for your pin.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
