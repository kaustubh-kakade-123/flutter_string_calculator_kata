import 'package:flutter/material.dart';
import 'package:string_calculator_kata/features/calculator/presentation/widgets/calculator_examples.dart';
import 'package:string_calculator_kata/features/calculator/presentation/widgets/calculator_header.dart';
import 'package:string_calculator_kata/features/calculator/presentation/widgets/calculator_input.dart';
import 'package:string_calculator_kata/features/calculator/presentation/widgets/calculator_result.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('String Calculator TDD Kata'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CalculatorHeader(),
            SizedBox(height: 16),
            CalculatorExamples(),
            SizedBox(height: 20),
            CalculatorInput(),
            SizedBox(height: 20),
            CalculatorResult(),
          ],
        ),
      ),
    );
  }
}
