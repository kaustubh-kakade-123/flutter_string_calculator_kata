part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class CalculateNumbers extends CalculatorEvent {
  final String numbers;

  const CalculateNumbers(this.numbers);

  @override
  List<Object> get props => [numbers];
}

class ClearCalculation extends CalculatorEvent {}

class InputChanged extends CalculatorEvent {
  final String input;

  const InputChanged(this.input);

  @override
  List<Object> get props => [input];
}
