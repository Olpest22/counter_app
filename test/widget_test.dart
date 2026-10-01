import 'package:flutter/material.dart';
import 'package:counter_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('показывает сохранённое значение при запуске', (tester) async {
    SharedPreferences.setMockInitialValues({'counter': 5});

    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();

    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('нажатие увеличивает и сохраняет значение', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byKey(const Key('incrementButton')));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('counter'), 1);
  });
}
