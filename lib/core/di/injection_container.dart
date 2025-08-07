import 'package:get_it/get_it.dart';
import 'package:string_calculator_kata/features/calculator/data/repositories_impl/calculator_repository_impl.dart';
import '../../features/calculator/data/datasources/calculator_local_datasource.dart';
import '../../features/calculator/domain/repositories/calculator_repository.dart';
import '../../features/calculator/domain/usecases/calculate_sum.dart';
import '../../features/calculator/presentation/bloc/calculator_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Calculator
  // Bloc
  sl.registerFactory(() => CalculatorBloc(calculateSum: sl()));

  // Use cases
  sl.registerLazySingleton(() => CalculateSum(sl()));

  // Repository
  sl.registerLazySingleton<CalculatorRepository>(
    () => CalculatorRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CalculatorLocalDataSource>(
    () => CalculatorLocalDataSourceImpl(),
  );
}
