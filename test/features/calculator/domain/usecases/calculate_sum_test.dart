import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:string_calculator_kata/core/errors/failures.dart';
import 'package:string_calculator_kata/features/calculator/domain/entities/calculation_results.dart';

import 'package:string_calculator_kata/features/calculator/domain/repositories/calculator_repository.dart';
import 'package:string_calculator_kata/features/calculator/domain/usecases/calculate_sum.dart';

import 'calculate_sum_test.mocks.dart';

@GenerateMocks([CalculatorRepository])
void main() {
  late CalculateSum usecase;
  late MockCalculatorRepository mockRepository;

  setUp(() {
    mockRepository = MockCalculatorRepository();
    usecase = CalculateSum(mockRepository);
  });

  const tNumbers = '1,2,3';
  final tCalculationResult = CalculationResult(
    sum: 6,
    input: tNumbers,
    timestamp: DateTime.now(),
  );

  test('should get calculation result from the repository', () async {
    // arrange
    when(mockRepository.calculateSum(any))
        .thenAnswer((_) async => Right(tCalculationResult));

    // act
    final result = await usecase(const Params(numbers: tNumbers));

    // assert
    expect(result, Right(tCalculationResult));
    verify(mockRepository.calculateSum(tNumbers));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    const tFailure = ValidationFailure('Invalid input');
    when(mockRepository.calculateSum(any))
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(const Params(numbers: tNumbers));

    // assert
    expect(result, const Left(tFailure));
    verify(mockRepository.calculateSum(tNumbers));
    verifyNoMoreInteractions(mockRepository);
  });
}
