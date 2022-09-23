// Package Imports
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinboard_clone/models/tag/tag.dart';
import 'package:pinboard_clone/ui/login/login_view.dart';

// Local Imports
import 'app/locator.dart';
import 'models/pinboard_pin/pinboard_pin.dart';
import 'models/tag/tag.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HiveInit().then((_) {
    // Start up our services
    setupLocator();
    // Run UI/collectives
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    // New widget to be home page
    // var pinsScreenView = LoginView();
    var pinsScreenView = LoginView();
    return MaterialApp(
      key: key,
      home: pinsScreenView,
      theme: ThemeData.dark(),
      title: 'Pin Bookmarks',
    );
  }
}

Future<bool> HiveInit() async {
  // Start Hive
  await Hive.initFlutter();
  // Register model adapters and create data 'boxes'
  // to allow local storage
  // Hive.registerAdapter(PinAdapter());
  await Hive.openBox('api_token');
  await Hive.openBox('pins');
  Hive.registerAdapter(TagAdapter());
  await Hive.openBox('tags');
  await Hive.openBox('current_tag');
  Hive.registerAdapter(PinboardPinAdapter());
  await Hive.openBox('pinboard_pins');

  return true;
}
