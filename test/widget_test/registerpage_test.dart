import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recan/screen/Entry/registerScreen.dart';

void main() {
  testWidgets('Register page test', (tester) async {
    // await tester.runAsync(() async {
      final username = find.byKey(const ValueKey("username"));
      final email = find.byKey(const ValueKey("email"));
      final password = find.byKey(const ValueKey("password"));
      final button = find.byKey(const ValueKey('register'));

      //
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: RegisterPage())));
      await tester.enterText(username, "sahrohit");
      await tester.enterText(email, "sarohit@gmail.com");
      await tester.enterText(password, "mko0mko0");
      await tester.tap(button);
      await tester.pump();

      //
      expect(find.text('sahrohit'), findsOneWidget);
      expect(find.text('sahrohit@gmail.com'), findsOneWidget);
      expect(find.text('mko0mko0'), findsOneWidget);
    });
  // });
}
