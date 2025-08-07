import 'package:dartz/dartz.dart';
import 'package:string_calculator_kata/core/errors/failures.dart';
import 'package:string_calculator_kata/features/calculator/domain/entities/calculation_results.dart';

abstract class CalculatorRepository {
  Future<Either<Failure, CalculationResult>> calculateSum(String numbers);
}
