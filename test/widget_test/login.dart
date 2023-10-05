import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recan/screen/Entry/loginScreen.dart';



void main() {
  testWidgets('login', (tester) async {
    // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    // await tester.runAsync(() async {
      final email = find.byKey(const ValueKey("email"));
      final password = find.byKey(const ValueKey("password"));
      final button = find.byKey(const ValueKey('login'));

      //
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: Login())));
      await tester.enterText(email, "sahrohit@gmail.com");
      await tester.enterText(password, "mko0mko0");
      await tester.tap(button);
      await tester.pumpAndSettle(const Duration(seconds:5));

      //
      expect(find.text('sahrohit@gmail.com'), findsOneWidget);
      expect(find.text('mko0mko0'), findsOneWidget);
    });
  // });
}
