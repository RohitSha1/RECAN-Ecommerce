import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recan/screen/Entry/registerScreen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Register page test', (tester) async {
    // await tester.runAsync(() async {
      final username = find.byKey(const ValueKey("username"));
      final email = find.byKey(const ValueKey("email"));
      final password = find.byKey(const ValueKey("password"));
      final button = find.byKey(const ValueKey('register'));

      //
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: RegisterPage())));
      await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/RegisterPage':(context)=>const RegisterPage(),
        },
        home: const RegisterPage(),
      ),
    );
      await tester.enterText(username, "sahrohit");
      await tester.enterText(email, "sahhrohit@gmail.com");
      await tester.enterText(password, "mko0mko0");
      await tester.tap(button);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      // await tester.pump();

      //
      expect(find.text('sahrohit'), findsOneWidget);
      expect(find.text('sahhrohit@gmail.com'), findsOneWidget);
      expect(find.text('mko0mko0'), findsOneWidget);
    });
}

// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:real_deal/pages/Register.dart';
// import 'package:real_deal/pages/login.dart';
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   testWidgets('Auto register integration test', (WidgetTester tester) async {
//     // await tester.runAsync(() async {
//     final username = find.byKey(const ValueKey("username"));
//     final email = find.byKey(const ValueKey("email"));
//     final password = find.byKey(const ValueKey("password"));
//     final button = find.byKey(const ValueKey('register'));
//     //
//     // await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: Register())));
//     await tester.pumpWidget(
//       MaterialApp(
//         routes: {
//           '/AuthScreen': (context) => const AuthScreen(),
//         },
//         home: const Register(),
//       ),
//     );
//     await tester.enterText(username, "ram");
//     await tester.enterText(email, "ab@gmail.com");
//     await tester.enterText(password, "123");
//     await tester.tap(button);
//     await tester.pumpAndSettle(const Duration(seconds: 2));
//     //
//     expect(find.text('ram'), findsOneWidget);
//     expect(find.text('ab@gmail.com'), findsOneWidget);
//     expect(find.text('123'), findsOneWidget);
//   });
//   // });
// }
