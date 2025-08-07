import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:string_calculator_kata/core/errors/failures.dart';
import 'package:string_calculator_kata/features/calculator/domain/entities/calculation_results.dart';
import 'package:string_calculator_kata/features/calculator/domain/usecases/calculate_sum.dart';
import 'package:string_calculator_kata/features/calculator/presentation/bloc/calculator_bloc.dart';

import '../../../../widget_test.mocks.dart';

@GenerateMocks([CalculateSum])
void main() {
  late CalculatorBloc bloc;
  late MockCalculateSum mockCalculateSum;

  setUp(() {
    mockCalculateSum = MockCalculateSum();
    bloc = CalculatorBloc(calculateSum: mockCalculateSum);
  });

  const tNumbers = '1,2,3';
  final tCalculationResult = CalculationResult(
    sum: 6,
    input: tNumbers,
    timestamp: DateTime.now(),
  );

  test('initial state should be CalculatorInitial', () {
    expect(bloc.state, equals(CalculatorInitial()));
  });

  group('CalculateNumbers', () {
    blocTest<CalculatorBloc, CalculatorState>(
      'should emit [CalculatorLoading, CalculatorLoaded] when data is gotten successfully',
      build: () {
        when(
          mockCalculateSum(any),
        ).thenAnswer((_) async => Right(tCalculationResult));
        return bloc;
      },
      act: (bloc) => bloc.add(const CalculateNumbers(tNumbers)),
      expect: () => [
        CalculatorLoading(),
        CalculatorLoaded(result: tCalculationResult),
      ],
      verify: (_) {
        verify(mockCalculateSum(const Params(numbers: tNumbers)));
      },
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'should emit [CalculatorLoading, CalculatorError] when getting data fails',
      build: () {
        when(mockCalculateSum(any)).thenAnswer(
          (_) async => const Left(ValidationFailure('Invalid input')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const CalculateNumbers(tNumbers)),
      expect: () => [
        CalculatorLoading(),
        const CalculatorError(message: 'Invalid input'),
      ],
      verify: (_) {
        verify(mockCalculateSum(const Params(numbers: tNumbers)));
      },
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'should emit proper error message for CalculationFailure',
      build: () {
        when(mockCalculateSum(any)).thenAnswer(
          (_) async =>
              const Left(CalculationFailure('negative numbers not allowed -1')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const CalculateNumbers('-1,2,3')),
      expect: () => [
        CalculatorLoading(),
        const CalculatorError(message: 'negative numbers not allowed -1'),
      ],
    );
  });

  group('ClearCalculation', () {
    blocTest<CalculatorBloc, CalculatorState>(
      'should emit CalculatorInitial when clear is called',
      build: () => bloc,
      act: (bloc) => bloc.add(ClearCalculation()),
      expect: () => [CalculatorInitial()],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'should clear calculation from loaded state',
      build: () {
        when(
          mockCalculateSum(any),
        ).thenAnswer((_) async => Right(tCalculationResult));
        return bloc;
      },
      act: (bloc) {
        bloc.add(const CalculateNumbers(tNumbers));
        return bloc.stream.take(2).drain().then((_) {
          bloc.add(ClearCalculation());
        });
      },
      expect: () => [
        CalculatorLoading(),
        CalculatorLoaded(result: tCalculationResult),
        CalculatorInitial(),
      ],
    );
  });

  group('InputChanged', () {
    blocTest<CalculatorBloc, CalculatorState>(
      'should emit CalculatorInitial when input changes and state is loaded',
      build: () {
        when(
          mockCalculateSum(any),
        ).thenAnswer((_) async => Right(tCalculationResult));
        return bloc;
      },
      act: (bloc) {
        bloc.add(const CalculateNumbers(tNumbers));
        return bloc.stream.take(2).drain().then((_) {
          bloc.add(const InputChanged('new input'));
        });
      },
      expect: () => [
        CalculatorLoading(),
        CalculatorLoaded(result: tCalculationResult),
        CalculatorInitial(),
      ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'should emit CalculatorInitial when input changes and state is error',
      build: () {
        when(mockCalculateSum(any)).thenAnswer(
          (_) async => const Left(ValidationFailure('Invalid input')),
        );
        return bloc;
      },
      act: (bloc) {
        bloc.add(const CalculateNumbers('invalid'));
        return bloc.stream.take(2).drain().then((_) {
          bloc.add(const InputChanged('new input'));
        });
      },
      expect: () => [
        CalculatorLoading(),
        const CalculatorError(message: 'Invalid input'),
        CalculatorInitial(),
      ],
    );
  });
}
