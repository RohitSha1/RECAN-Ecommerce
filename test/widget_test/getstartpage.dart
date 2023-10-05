
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recan/screen/myOrderPage.dart';

void main() {
  testWidgets('Orderpage test', (tester) async {
    await tester
        .pumpWidget(const ProviderScope(child: MaterialApp(home: MyOrderPage(data: null,))));
    final title = find.byType(SafeArea);
    expect(title, findsOneWidget);
  });
}
