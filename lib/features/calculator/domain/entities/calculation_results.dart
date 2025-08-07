import 'package:equatable/equatable.dart';

class CalculationResult extends Equatable {
  final int sum;
  final String input;
  final DateTime timestamp;

  const CalculationResult({
    required this.sum,
    required this.input,
    required this.timestamp,
  });

  @override
  List<Object> get props => [sum, input, timestamp];
}
