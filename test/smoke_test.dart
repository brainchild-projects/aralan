import 'package:aralan/main.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('It should show heading', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    expect(find.text('Today’s Schedule'), findsOneWidget);
  });
}
