// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import 'post_single_viewmodel.dart';
import '../../../models/post/post.dart';
import '../pins_screen/pins_screen_view.dart';

class PostSingleView extends StatefulWidget {
  const PostSingleView(
      {super.key, required this.post, required this.urlController});

  final Post post;
  final TextEditingController urlController;

  @override
  State<PostSingleView> createState() => _PostSingleViewState();
}

class _PostSingleViewState extends State<PostSingleView> {
  @override
  Widget build(BuildContext context) {
    FocusNode descriptionFocusNode = new FocusNode();
    FocusNode urlFocusNode = new FocusNode();

    return ViewModelBuilder<PostSingleViewModel>.reactive(
        viewModelBuilder: () => PostSingleViewModel(widget.post.id),
        builder: (context, model, _) => Scaffold(
            appBar: AppBar(
              title: Text(widget.post.description),
              actions: <Widget>[
                IconButton(
                    onPressed: () => _tryDelete(widget.post.id, model),
                    icon: const Icon(Icons.delete_outline))
              ],
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: TextField(
                    // See above
                    controller:
                        TextEditingController(text: widget.post.description),
                    focusNode: descriptionFocusNode,
                    onChanged: (text) => model.updatePinDataContent(
                      id: widget.post.id,
                      url: widget.post.url,
                      description: text,
                      tag: widget.post.tag,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    focusNode: model.getFocusNode(widget.post.id),
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(descriptionFocusNode);
                    },
                  ),
                ),
                ListTile(
                  title: TextField(
                    // See above
                    controller: widget.urlController,

                    // ignore: deprecated_member_use
                    onTap: () => {
                      if (widget.post.url == null)
                        {
                          launch("https://www.google.com"),
                        }
                      else
                        {launch("https://" + widget.post.url)}
                    },
                    onChanged: (text) => model.updatePinDataContent(
                      id: widget.post.id,
                      url: text,
                      description: widget.post.description,
                      tag: widget.post.tag,
                    ),
                    focusNode: urlFocusNode,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    focusNode: model.getFocusNode(widget.post.id),
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(urlFocusNode);
                    },
                  ),
                ),
                ListTile(
                  title: TextField(
                    // See above
                    controller: TextEditingController(
                        // Concatenated string ->
                        text: (DateFormat('yyyy-MM-dd')
                                .format(widget.post.datetime) +
                            " at " +
                            DateFormat('jm').format(widget.post.datetime))),
                    focusNode: new AlwaysDisabledFocusNode(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    focusNode: AlwaysDisabledFocusNode(),
                    icon: Icon(Icons.date_range),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  leading: Text("Tags: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  title: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.tag),
                          Text(widget.post.tag.tag),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  Future<void> _tryDelete(String id, PostSingleViewModel model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete this pin?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                model.removePin(widget.post.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
