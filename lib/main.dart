// Package Imports
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinboard_clone/models/tag/tag.dart';
import 'package:pinboard_clone/ui/login/login_view.dart';
import 'package:pinboard_clone/ui/pins_list/pins_list_view.dart';

// Local Imports
import 'app/globals.dart';
import 'app/locator.dart';
import 'data_sources/pinboard_api/tag_api.services.dart';
import 'models/pinboard_pin/pinboard_pin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  StorageInit().then((_) {
    // Start up our services
    setupLocator();
    // execute();
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
    return MaterialApp.router(
      key: key,
      theme: ThemeData.dark(),
      title: 'Pin Bookmarks',
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: ((context, state) {
          return LoginView();
        })),
    GoRoute(
        path: '/pins',
        builder: ((context, state) {
          return PinsListView();
        })),
  ]);
}

Future<bool> StorageInit() async {
  // Start Hive Cache
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

  // init the isar database
  // await AppStorage.initIsar();

  return true;
}

Future<void> execute() async {
  // Execute arbitrary code for debugging purposes only
  //
  var ser = TagAPIService();
  var tok = ser.setToken("bshap93:1A2DC6C239D948A40F2C");
  print(ser.loginService.getAuthAppendage("bshap93:1A2DC6C239D948A40F2C"));

  var obj = await ser.suggestTags("https://benshapiro.io/");

  print(obj.toString());
  //
}
