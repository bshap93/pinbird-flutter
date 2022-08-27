import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinboard_clone/models/pin_data.dart';
import 'package:pinboard_clone/models/tag.dart';

import 'app/locator.dart';
import 'models/pin.adapter.dart';
import 'ui/pins_screen/pins_screen_view.dart';
import 'models/pin_data.dart';
import 'models/tag.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(TagAdapter());
  // Hive.registerAdapter(PinDataAdapter());
  Hive.registerAdapter(PinAdapter());
  await Hive.openBox('pins');
  // await Hive.openBox('pin_data');
  Hive.registerAdapter(TagAdapter());
  await Hive.openBox('tags');

  Hive.registerAdapter(PinDataAdapter());
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
