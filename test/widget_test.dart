import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:roastlab/main.dart';

void main() {
  testWidgets('shows the RoastLab shell', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('RoastLab'), findsWidgets);
    expect(find.text('Coffee with a sharper aesthetic.'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('Brew'));
    await tester.pumpAndSettle();

    expect(find.text('Brew Studio'), findsOneWidget);
    expect(find.text('Brew like it is styled.'), findsOneWidget);
  });
}
