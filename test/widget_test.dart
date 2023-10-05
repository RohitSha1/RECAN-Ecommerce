import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recan/screen/Entry/loginScreen.dart';



// void main() {
//   testWidgets('Counter', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const ProductPage());

//     // Verify that our counter starts at 0.
//     expect(find.text('RECANAPP'), findsOneWidget);
//     expect(find.text('Homee'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('RECANAPP'), findsNothing);
//     expect(find.text('Home'), findsOneWidget);
//   });
// }
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Login());

    // Verify that our counter starts at 0.
    expect(find.text('RECANAPP'), findsOneWidget);
    expect(find.text('HOME'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
