// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:smartbee_app/main.dart';

void main() {
  testWidgets('Splash screen shows correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SmartBeeApp());

    // Verify that the splash screen text exists.
    expect(find.text('Klik di mana saja untuk melanjutkan.'), findsOneWidget);

    // Verify that the logo text exists.
    expect(find.text('SMART BEE'), findsOneWidget);
    expect(find.text('CONNECT. LEARN. GROW.'), findsOneWidget);
  });
}
