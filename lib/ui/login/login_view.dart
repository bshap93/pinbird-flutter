import 'package:flutter/material.dart';
import 'package:pinboard_clone/ui/pinboard_pins/recent_pins/recent_pins_view.dart';
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
                title: Text("Login"),
                actions: <Widget>[],
              ),
              body: Column(
                children: [
                  Center(
                    child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Enter you API Token: '),
                        controller: tokenController,
                        onSubmitted: (_) => submitData(context, model)),
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
                      child: Text('Enter the Token.')),
                ],
              ),
            ));
  }

  submitData(BuildContext context, LoginViewModel model) {
    final enteredToken = tokenController.text;
    model.startLogin(enteredToken);
    print("Login started");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecentPinsView()));
  }
}
