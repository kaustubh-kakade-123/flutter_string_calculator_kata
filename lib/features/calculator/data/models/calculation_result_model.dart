import 'package:string_calculator_kata/features/calculator/domain/entities/calculation_results.dart';

class CalculationResultModel extends CalculationResult {
  const CalculationResultModel({
    required super.sum,
    required super.input,
    required super.timestamp,
  });

  factory CalculationResultModel.fromEntity(CalculationResult entity) {
    return CalculationResultModel(
      sum: entity.sum,
      input: entity.input,
      timestamp: entity.timestamp,
    );
  }

  factory CalculationResultModel.create({
    required int sum,
    required String input,
  }) {
    return CalculationResultModel(
      sum: sum,
      input: input,
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sum': sum,
      'input': input,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory CalculationResultModel.fromJson(Map<String, dynamic> json) {
    return CalculationResultModel(
      sum: json['sum'],
      input: json['input'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
