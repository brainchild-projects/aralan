import 'package:aralan/main.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('It should show heading', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
    // Build our app and trigger a frame.
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(App(prefs: prefs));

    expect(find.text('Today’s Schedule'), findsOneWidget);
  });
}
