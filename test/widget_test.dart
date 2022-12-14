// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pinboard_clone/main.dart';
import 'package:pinboard_clone/ui/pins_list/pins_list_view.dart';
import 'package:stacked/stacked.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  testWidgets('Pins screen view has no pins', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PinsListView());

    final noPinMsg = find.text('No pins yet. Click + to add a new one.');

    // Verify that our counter starts at 0.
    expect(noPinMsg, findsOneWidget);
  });

  // testWidgets('description', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MyApp());

  //   final homeFind = find.byElementType(MaterialApp);

  //   expect(homeFind, findsOneWidget);
  // });
}
