import 'package:flutter/material.dart';

class CalculatorExamples extends StatelessWidget {
  const CalculatorExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Examples:',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildExample('Empty string: ""'),
            _buildExample('Single number: "5"'),
            _buildExample('Multiple numbers: "1,2,3"'),
            _buildExample('With newlines: "1\\n2,3"'),
            _buildExample('Custom delimiter: "//;\\n1;2;3"'),
          ],
        ),
      ),
    );
  }

  Widget _buildExample(String example) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text('• $example'),
    );
  }
}
