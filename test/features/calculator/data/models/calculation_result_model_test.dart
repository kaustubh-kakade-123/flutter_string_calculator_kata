import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator_kata/features/calculator/data/models/calculation_result_model.dart';
import 'package:string_calculator_kata/features/calculator/domain/entities/calculation_results.dart';

void main() {
  final tCalculationResultModel = CalculationResultModel.create(
    sum: 6,
    input: '1,2,3',
  );

  test('should be a subclass of CalculationResult entity', () async {
    // assert
    expect(tCalculationResultModel, isA<CalculationResult>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'sum': 6,
        'input': '1,2,3',
        'timestamp': '2023-01-01T12:00:00.000Z',
      };

      // act
      final result = CalculationResultModel.fromJson(jsonMap);

      // assert
      expect(result, isA<CalculationResultModel>());
      expect(result.sum, equals(6));
      expect(result.input, equals('1,2,3'));
      expect(
        result.timestamp,
        equals(DateTime.parse('2023-01-01T12:00:00.000Z')),
      );
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tCalculationResultModel.toJson();

      // assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['sum'], equals(6));
      expect(result['input'], equals('1,2,3'));
      expect(result['timestamp'], isA<String>());
    });
  });

  group('fromEntity', () {
    test('should create model from entity', () async {
      // arrange
      final entity = CalculationResult(
        sum: 10,
        input: '4,6',
        timestamp: DateTime.now(),
      );

      // act
      final result = CalculationResultModel.fromEntity(entity);

      // assert
      expect(result, isA<CalculationResultModel>());
      expect(result.sum, equals(entity.sum));
      expect(result.input, equals(entity.input));
      expect(result.timestamp, equals(entity.timestamp));
    });
  });

  group('create', () {
    test('should create model with current timestamp', () async {
      // arrange
      final beforeCreation = DateTime.now();

      // act
      final result = CalculationResultModel.create(sum: 15, input: '7,8');

      final afterCreation = DateTime.now();

      // assert
      expect(result.sum, equals(15));
      expect(result.input, equals('7,8'));
      expect(
        result.timestamp.isAfter(beforeCreation) ||
            result.timestamp.isAtSameMomentAs(beforeCreation),
        true,
      );
      expect(
        result.timestamp.isBefore(afterCreation) ||
            result.timestamp.isAtSameMomentAs(afterCreation),
        true,
      );
    });
  });
}
