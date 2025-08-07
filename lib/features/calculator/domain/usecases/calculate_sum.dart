import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:string_calculator_kata/core/errors/failures.dart';
import 'package:string_calculator_kata/features/calculator/domain/entities/calculation_results.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/calculator_repository.dart';

class CalculateSum implements UseCase<CalculationResult, Params> {
  final CalculatorRepository repository;

  CalculateSum(this.repository);

  @override
  Future<Either<Failure, CalculationResult>> call(Params params) async {
    return await repository.calculateSum(params.numbers);
  }
}

class Params extends Equatable {
  final String numbers;

  const Params({required this.numbers});

  @override
  List<Object> get props => [numbers];
}
