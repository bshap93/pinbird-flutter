// Package Imports
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinboard_clone/models/pin_data.dart';
import 'package:pinboard_clone/models/tag.dart';

// Local Imports
import 'app/locator.dart';
import 'ui/pins_screen/pins_screen_view.dart';
import 'models/pin_data.dart';
import 'models/tag.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Start Hive
  await Hive.initFlutter();
  // Register model adapters and create data 'boxes'
  // to allow local storage
  // Hive.registerAdapter(PinAdapter());
  await Hive.openBox('pins');
  Hive.registerAdapter(TagAdapter());
  await Hive.openBox('tags');
  await Hive.openBox('current_tag');
  Hive.registerAdapter(PinDataAdapter());
  await Hive.openBox('pin_data');

  // Start up our services
  setupLocator();
  // Run UI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // New widget to be home page
    var pinsScreenView = PinsScreenView();
    return MaterialApp(
      home: pinsScreenView,
      theme: ThemeData.dark(),
      title: 'Pin Bookmarks',
    );
  }
}
