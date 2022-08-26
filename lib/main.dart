import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/locator.dart';
import 'models/pin.adapter.dart';
import 'ui/pins_screen/pins_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PinAdapter());
  await Hive.openBox('pins');
  await Hive.openBox('pin_data');

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pinsScreenView = PinsScreenView();
    return MaterialApp(
      home: pinsScreenView,
      theme: ThemeData.dark(),
      title: 'Pin Bookmarks',
    );
  }
}
