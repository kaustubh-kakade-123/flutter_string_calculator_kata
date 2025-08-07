import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator_kata/core/errors/exception.dart';
import 'package:string_calculator_kata/features/calculator/data/datasources/calculator_local_datasource.dart';

void main() {
  late CalculatorLocalDataSourceImpl dataSource;

  setUp(() {
    dataSource = CalculatorLocalDataSourceImpl();
  });

  group('calculateSum', () {
    test(
      'should return CalculationResultModel with sum 0 for empty string',
      () async {
        // act
        final result = await dataSource.calculateSum('');

        // assert
        expect(result.sum, equals(0));
        expect(result.input, equals(''));
      },
    );

    test(
      'should return CalculationResultModel with correct sum for single number',
      () async {
        // act
        final result = await dataSource.calculateSum('5');

        // assert
        expect(result.sum, equals(5));
        expect(result.input, equals('5'));
      },
    );

    test(
      'should return CalculationResultModel with correct sum for comma-separated numbers',
      () async {
        // act
        final result = await dataSource.calculateSum('1,2,3');

        // assert
        expect(result.sum, equals(6));
        expect(result.input, equals('1,2,3'));
      },
    );

    test('should handle newlines between numbers', () async {
      // act
      final result = await dataSource.calculateSum('1\n2,3');

      // assert
      expect(result.sum, equals(6));
    });

    test('should handle custom delimiter', () async {
      // act
      final result = await dataSource.calculateSum('//;\n1;2;3');

      // assert
      expect(result.sum, equals(6));
    });

    test('should throw CalculationException for negative numbers', () async {
      // act & assert
      expect(
        () => dataSource.calculateSum('1,-2,3'),
        throwsA(isA<CalculationException>()),
      );
    });

    test(
      'should throw ValidationException for invalid number format',
      () async {
        // act & assert
        expect(
          () => dataSource.calculateSum('1,a,3'),
          throwsA(isA<ValidationException>()),
        );
      },
    );

    test(
      'should throw ValidationException for invalid delimiter format',
      () async {
        // act & assert
        expect(
          () => dataSource.calculateSum('//;'),
          throwsA(isA<ValidationException>()),
        );
      },
    );
  });
}
