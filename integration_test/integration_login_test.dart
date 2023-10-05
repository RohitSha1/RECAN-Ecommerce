import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recan/screen/Entry/loginScreen.dart';
import 'package:recan/screen/Entry/registerScreen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Login Integration Testing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes:{
          '/RegisterPage':(context)=>const RegisterPage(),
        },
        home: const Login(),
      ),
    );
    Finder textEmail = find.byKey(const ValueKey('email'));
    await tester.enterText(textEmail, 'rohit@gmail.com');
    Finder textPassword = find.byKey(const ValueKey('password'));
    await tester.enterText(textPassword, '12345679');
    Finder button = find.byKey(const ValueKey(''));
    await tester.tap(button);
    await tester.pumpAndSettle(const Duration(seconds:5));
    expect(find.byType(Scaffold), findsOneWidget);
  });
}