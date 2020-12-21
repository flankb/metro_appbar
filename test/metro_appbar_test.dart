import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

Type getType<T>() => T;

void main() {
  testWidgets('MetroAppBar test', (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(TestApp());

    var state =
        widgetTester.state<MyTestHomePageState>(find.byType(MyTestHomePage));

    await widgetTester.tap(find.text('Ipsum'));
    await widgetTester.pump();

    expect(state.pushedButtonText, 'Ipsum');

    await widgetTester.tap(find.byType(getType<PopupMenuButton<int>>()));
    await widgetTester.pump();
    await widgetTester
        .pump(const Duration(seconds: 1)); // Finish menu animation

    await widgetTester.tap(find.text('Secondary'));
    await widgetTester.pump(); // return the future

    state =
        widgetTester.state<MyTestHomePageState>(find.byType(MyTestHomePage));
    expect(state.pushedButtonText, 'Secondary');
  });
}
