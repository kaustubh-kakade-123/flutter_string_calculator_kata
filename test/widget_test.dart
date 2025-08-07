import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:string_calculator_kata/features/calculator/domain/usecases/calculate_sum.dart';
import 'package:string_calculator_kata/features/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:string_calculator_kata/features/calculator/presentation/pages/calculator_page.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([CalculateSum])
void main() {
  late MockCalculateSum mockCalculateSum;

  setUp(() {
    mockCalculateSum = MockCalculateSum();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<CalculatorBloc>(
        create: (context) => CalculatorBloc(calculateSum: mockCalculateSum),
        child: const CalculatorPage(),
      ),
    );
  }

  group('CalculatorPage Widget Tests', () {
    testWidgets('should display app title', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('String Calculator TDD Kata'), findsOneWidget);
    });

    testWidgets('should have input field and buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Calculate'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);
    });

    testWidgets('should display examples section', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Examples:'), findsOneWidget);
      expect(find.text('• Empty string: ""'), findsOneWidget);
      expect(find.text('• Single number: "5"'), findsOneWidget);
      expect(find.text('• Multiple numbers: "1,2,3"'), findsOneWidget);
    });

    testWidgets('should display header section', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('String Calculator'), findsOneWidget);
      expect(
        find.text('Enter comma-separated numbers or use custom delimiters'),
        findsOneWidget,
      );
    });

    testWidgets('should show loading indicator when calculating', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap calculate button (this will trigger loading state in the bloc)
      await tester.tap(find.text('Calculate'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should clear text field when clear button is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter some text
      await tester.enterText(find.byType(TextField), '1,2,3');
      expect(find.text('1,2,3'), findsOneWidget);

      // Tap clear button
      await tester.tap(find.text('Clear'));
      await tester.pump();

      // Verify text is cleared
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('should have proper form elements', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Numbers'), findsOneWidget);
      expect(
        find.text('Enter numbers (e.g., 1,2,3 or //;\\n1;2;3)'),
        findsOneWidget,
      );
    });
  });
}
