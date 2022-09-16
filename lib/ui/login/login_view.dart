import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/api_serviced_views/pins_list/pins_list_view.dart';
import 'package:stacked/stacked.dart';
// project files
import '../shared/dialogs.dart';
import '../shared/styles.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final tokenController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FocusNode apiTokenFocusNode = new FocusNode();

    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                  title: Text("Login via Pinboard"),
                  leading: IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                      ))),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                                decoration: InputDecoration(
                                    labelText: 'Enter you API Token: '),
                                controller: tokenController,
                                onSubmitted: (_) => submitData(context, model)),
                          ),
                        ),
                        ElevatedButton(
                            style: Styles.buttonStyle1,
                            onPressed: () {
                              if (tokenController.text.isEmpty) {
                                Dialogs.showNoURLDialog(context);
                              } else {
                                submitData(context, model);
                              }
                            },
                            child: Text('Submit')),
                        // TextButton(
                        //   child: Text('Or Continue with Only Local Data'),
                        //   onPressed: () => Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => PinsScreenView())),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  submitData(BuildContext context, LoginViewModel model) {
    final enteredToken = tokenController.text;
    model.startLogin(enteredToken);
    print("Login started");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PinsListView()));
  }
}
