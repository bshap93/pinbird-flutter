import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatDateTime(String time) {
    return "${DateFormat('yyyy-MM-dd').format(DateTime.parse(time))} at ${DateFormat('jm').format(DateTime.parse(time))}";
  }

  static String formatDate(String time) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(time));
  }

  static Widget ifShowTags(String tags) {
    if (tags.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Tags: ${tags}",
            textAlign: TextAlign.left,
          ),
        ],
      );
    } else {
      return Padding(padding: EdgeInsets.zero);
    }
  }

  // internal functions
}
