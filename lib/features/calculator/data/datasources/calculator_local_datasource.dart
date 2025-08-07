import 'package:string_calculator_kata/core/errors/exception.dart';

import '../models/calculation_result_model.dart';

abstract class CalculatorLocalDataSource {
  /// Performs the string calculator algorithm
  ///
  /// Throws [CalculationException] for any calculation errors
  /// Throws [ValidationException] for invalid inputs
  Future<CalculationResultModel> calculateSum(String numbers);
}

class CalculatorLocalDataSourceImpl implements CalculatorLocalDataSource {
  @override
  Future<CalculationResultModel> calculateSum(String numbers) async {
    try {
      final result = _performCalculation(numbers);
      return CalculationResultModel.create(sum: result, input: numbers);
    } on ValidationException {
      rethrow;
    } on CalculationException {
      rethrow;
    } catch (e) {
      throw CalculationException('Unexpected error during calculation: $e');
    }
  }

  int _performCalculation(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    String delimiter = ',';
    String numbersToProcess = numbers;

    // Check for custom delimiter
    if (numbers.startsWith('//')) {
      final delimiterEnd = numbers.indexOf('\n');
      if (delimiterEnd == -1) {
        throw ValidationException('Invalid custom delimiter format');
      }

      delimiter = numbers.substring(2, delimiterEnd);
      if (delimiter.isEmpty) {
        throw ValidationException('Delimiter cannot be empty');
      }

      numbersToProcess = numbers.substring(delimiterEnd + 1);
    }

    // Replace newlines with the current delimiter for uniform processing
    numbersToProcess = numbersToProcess.replaceAll('\n', delimiter);

    // Split by delimiter and process numbers
    final numberStrings = numbersToProcess.split(delimiter);
    final parsedNumbers = <int>[];
    final negativeNumbers = <int>[];

    for (final numberStr in numberStrings) {
      if (numberStr.trim().isEmpty) continue;

      try {
        final number = int.parse(numberStr.trim());
        if (number < 0) {
          negativeNumbers.add(number);
        }
        parsedNumbers.add(number);
      } catch (e) {
        throw ValidationException('Invalid number format: "$numberStr"');
      }
    }

    // Check for negative numbers
    if (negativeNumbers.isNotEmpty) {
      final negativesList = negativeNumbers.join(', ');
      throw CalculationException('negative numbers not allowed $negativesList');
    }

    // Return sum of all numbers
    return parsedNumbers.fold(0, (sum, number) => sum + number);
  }
}
