import 'package:flutter/material.dart';
import 'package:flutter_counter/app.dart';
import 'package:flutter_counter/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Counters initial data", (WidgetTester tester) async {
    await tester.pumpWidget(const CounterView());

    expect(find.text('initial-d'), findsOneWidget);
    expect(find.text('Data: '), findsNothing);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    expect(find.text('initial-d'), findsNothing);
    expect(find.text('Data: 1'), findsOneWidget);
  });
}
