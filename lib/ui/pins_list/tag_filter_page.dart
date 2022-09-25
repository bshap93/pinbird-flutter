import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

import '../../models/tag/tag.dart';

class TagFilterPage extends StatelessWidget {
  const TagFilterPage({Key? key, this.tagList, this.selectedTagList})
      : super(key: key);
  final List<Tag>? selectedTagList;
  final List<Tag>? tagList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilterListWidget<Tag>(
        listData: tagList,
        // themeData: FilterListThemeData.dark(context),
        backgroundColor: ThemeData.dark().colorScheme.background,
        selectedListData: selectedTagList,
        enableOnlySingleSelection: true,
        onApplyButtonClick: (list) {
          // do something with list ..
          Navigator.pop(context);
        },
        choiceChipLabel: (item) {
          /// Used to display text on chip
          return item!.tag;
        },
        validateSelectedItem: (list, val) {
          ///  identify if item is selected or not
          return list!.contains(val);
        },
        onItemSearch: (tag, query) {
          /// When search query change in search bar then this method will be called
          ///
          /// Check if items contains query
          return tag.tag!.toLowerCase().contains(query.toLowerCase());
        },
      ),
    );
  }
}
