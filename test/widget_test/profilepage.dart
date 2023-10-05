// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:recan/screen/Profile.dart';

// void main() {
//   testWidgets('Profile page test', (tester) async {
//     // await tester.runAsync(() async {
//       final title = find.byKey(const ValueKey("title"));
//       final catagory = find.byKey(const ValueKey("catagory"));
//       final description = find.byKey(const ValueKey("description"));
//       final button = find.byKey(const ValueKey('Post'));

//       //
//       await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: Profile())));
//       await tester.enterText(title, "Iphone");
//       await tester.enterText(catagory, "Mobile");
//       await tester.enterText(description, "Hello Softwarica");
//       await tester.tap(button);
//       await tester.pump();

//       //
//       expect(find.text('Iphone'), findsOneWidget);
//       expect(find.text('Mobile'), findsOneWidget);
//       expect(find.text('Hello Softwarica'), findsOneWidget);
//     });
// }
