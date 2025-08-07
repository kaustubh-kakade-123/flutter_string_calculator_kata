import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'features/calculator/presentation/pages/calculator_page.dart';
import 'features/calculator/presentation/bloc/calculator_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const StringCalculatorApp());
}

class StringCalculatorApp extends StatelessWidget {
  const StringCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Calculator TDD Kata',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => di.sl<CalculatorBloc>(),
        child: const CalculatorPage(),
      ),
    );
  }
}
