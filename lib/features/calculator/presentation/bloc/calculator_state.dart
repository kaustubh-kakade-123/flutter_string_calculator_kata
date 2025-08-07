part of 'calculator_bloc.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoading extends CalculatorState {}

class CalculatorLoaded extends CalculatorState {
  final CalculationResult result;

  const CalculatorLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class CalculatorError extends CalculatorState {
  final String message;

  const CalculatorError({required this.message});

  @override
  List<Object> get props => [message];
}

class CalculatorInputChanged extends CalculatorState {
  final String input;

  const CalculatorInputChanged({required this.input});

  @override
  List<Object> get props => [input];
}
