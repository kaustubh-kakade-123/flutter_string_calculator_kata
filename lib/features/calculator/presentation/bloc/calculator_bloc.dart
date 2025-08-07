import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:string_calculator_kata/core/errors/failures.dart';
import 'package:string_calculator_kata/features/calculator/domain/entities/calculation_results.dart';
import '../../domain/usecases/calculate_sum.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculateSum calculateSum;

  CalculatorBloc({required this.calculateSum}) : super(CalculatorInitial()) {
    on<CalculateNumbers>(_onCalculateNumbers);
    on<ClearCalculation>(_onClearCalculation);
    on<InputChanged>(_onInputChanged);
  }

  void _onCalculateNumbers(
    CalculateNumbers event,
    Emitter<CalculatorState> emit,
  ) async {
    emit(CalculatorLoading());

    final failureOrResult = await calculateSum(Params(numbers: event.numbers));

    failureOrResult.fold(
      (failure) =>
          emit(CalculatorError(message: _mapFailureToMessage(failure))),
      (result) => emit(CalculatorLoaded(result: result)),
    );
  }

  void _onClearCalculation(
    ClearCalculation event,
    Emitter<CalculatorState> emit,
  ) {
    emit(CalculatorInitial());
  }

  void _onInputChanged(InputChanged event, Emitter<CalculatorState> emit) {
    // Clear any existing results/errors when input changes
    if (state is CalculatorLoaded || state is CalculatorError) {
      emit(CalculatorInitial());
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Use proper type checking instead of runtimeType with switch
    if (failure is ValidationFailure) {
      return failure.message;
    } else if (failure is CalculationFailure) {
      return failure.message;
    } else if (failure is ServerFailure) {
      return SERVER_FAILURE_MESSAGE;
    } else if (failure is CacheFailure) {
      return CACHE_FAILURE_MESSAGE;
    } else {
      return 'Unexpected Error';
    }
  }
}
