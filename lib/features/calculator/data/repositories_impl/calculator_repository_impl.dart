import 'package:dartz/dartz.dart';
import 'package:string_calculator_kata/core/errors/exception.dart';
import 'package:string_calculator_kata/core/errors/failures.dart';
import 'package:string_calculator_kata/features/calculator/domain/entities/calculation_results.dart';

import '../../domain/repositories/calculator_repository.dart';
import '../datasources/calculator_local_datasource.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  final CalculatorLocalDataSource localDataSource;

  CalculatorRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, CalculationResult>> calculateSum(
    String numbers,
  ) async {
    try {
      final result = await localDataSource.calculateSum(numbers);
      return Right(result);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on CalculationException catch (e) {
      return Left(CalculationFailure(e.message));
    } catch (e) {
      return Left(CalculationFailure('Unexpected error: $e'));
    }
  }
}
