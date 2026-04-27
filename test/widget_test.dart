import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:roastlab/main.dart';

void main() {
  testWidgets('shows onboarding and complete app flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('RoastLab'), findsOneWidget);
    expect(find.text('Enter App'), findsOneWidget);

    await tester.tap(find.text('Enter App'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('RoastLab'), findsOneWidget);

    await tester.tap(find.text('Brew'));
    await tester.pumpAndSettle();

    expect(find.text('Brew Studio'), findsOneWidget);

    await tester.tap(find.text('Roast'));
    await tester.pumpAndSettle();
    expect(find.text('Roast Shelf'), findsOneWidget);

    await tester.tap(find.text('Feed'));
    await tester.pumpAndSettle();
    expect(find.text('Community'), findsOneWidget);

    await tester.tap(find.text('You'));
    await tester.pumpAndSettle();
    expect(find.text('Your Profile'), findsOneWidget);
  });
}
