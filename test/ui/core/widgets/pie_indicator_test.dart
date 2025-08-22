import 'package:flutter/material.dart';
import 'package:flutter_checklist/ui/core/widgets/pie_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PieIndicator shows check icon when value is 1', (t) async {
    await t.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: PieIndicator(size: 40, value: 1),
          ),
        ),
      ),
    );
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('PieIndicator shows CircularProgressIndicator widget when value is < 1', (
    t,
  ) async {
    await t.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: PieIndicator(size: 40, value: .5),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.check), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
