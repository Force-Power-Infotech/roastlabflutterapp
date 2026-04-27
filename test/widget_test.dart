import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:roastlab/app.dart';

void main() {
  testWidgets('boots into the RoastLab splash experience', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: RoastLabBootstrap()));

    expect(find.text('RoastLab'), findsOneWidget);
    expect(find.text('Coffee intelligence for every brew'), findsOneWidget);
  });
}
