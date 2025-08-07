import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:string_calculator_kata/core/errors/exception.dart';
import 'package:string_calculator_kata/core/errors/failures.dart';

import 'package:string_calculator_kata/features/calculator/data/datasources/calculator_local_datasource.dart';
import 'package:string_calculator_kata/features/calculator/data/models/calculation_result_model.dart';
import 'package:string_calculator_kata/features/calculator/data/repositories_impl/calculator_repository_impl.dart';

import 'calculator_repository_impl_test.mocks.dart';

@GenerateMocks([CalculatorLocalDataSource])
void main() {
  late CalculatorRepositoryImpl repository;
  late MockCalculatorLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockCalculatorLocalDataSource();
    repository = CalculatorRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  const tNumbers = '1,2,3';
  final tCalculationResultModel = CalculationResultModel.create(
    sum: 6,
    input: tNumbers,
  );

  group('calculateSum', () {
    test(
      'should return CalculationResult when the call to local data source is successful',
      () async {
        // arrange
        when(
          mockLocalDataSource.calculateSum(any),
        ).thenAnswer((_) async => tCalculationResultModel);

        // act
        final result = await repository.calculateSum(tNumbers);

        // assert
        expect(result, equals(Right(tCalculationResultModel)));
        verify(mockLocalDataSource.calculateSum(tNumbers));
        verifyNoMoreInteractions(mockLocalDataSource);
      },
    );

    test(
      'should return ValidationFailure when ValidationException is thrown',
      () async {
        // arrange
        when(
          mockLocalDataSource.calculateSum(any),
        ).thenThrow(ValidationException('Invalid input'));

        // act
        final result = await repository.calculateSum(tNumbers);

        // assert
        expect(result, equals(const Left(ValidationFailure('Invalid input'))));
        verify(mockLocalDataSource.calculateSum(tNumbers));
        verifyNoMoreInteractions(mockLocalDataSource);
      },
    );

    test(
      'should return CalculationFailure when CalculationException is thrown',
      () async {
        // arrange
        when(
          mockLocalDataSource.calculateSum(any),
        ).thenThrow(CalculationException('negative numbers not allowed -1'));

        // act
        final result = await repository.calculateSum(tNumbers);

        // assert
        expect(
          result,
          equals(
            const Left(CalculationFailure('negative numbers not allowed -1')),
          ),
        );
        verify(mockLocalDataSource.calculateSum(tNumbers));
        verifyNoMoreInteractions(mockLocalDataSource);
      },
    );

    test(
      'should return CalculationFailure when unexpected exception is thrown',
      () async {
        // arrange
        when(
          mockLocalDataSource.calculateSum(any),
        ).thenThrow(Exception('Something went wrong'));

        // act
        final result = await repository.calculateSum(tNumbers);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<CalculationFailure>()),
          (r) => fail('Should have returned a failure'),
        );
        verify(mockLocalDataSource.calculateSum(tNumbers));
        verifyNoMoreInteractions(mockLocalDataSource);
      },
    );
  });
}
