import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pins_list/pins_list_viewmodel.dart';

class Formatter {
  static String formatDateTime(String time) {
    return "${DateFormat('yyyy-MM-dd').format(DateTime.parse(time))} at ${DateFormat('jm').format(DateTime.parse(time))}";
  }

  static String formatDate(String time) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(time));
  }

  static Widget ifShowTags(String tags, PinsListViewModel model) {
    if (tags.isNotEmpty) {
      List<String> listOfTagStrings = tags.split(' ');
      return Row(
        children: [
          ...listOfTagStrings.map((tag) {
            return ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeData.dark().colorScheme.background),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () => {
                      //
                    },
                child: Text(tag));
          })
        ],
      );
    } else {
      return const Padding(padding: EdgeInsets.zero);
    }
  }

  // internal functions
}
