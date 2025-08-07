import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calculator_bloc.dart';

class CalculatorInput extends StatefulWidget {
  const CalculatorInput({super.key});

  @override
  State<CalculatorInput> createState() => _CalculatorInputState();
}

class _CalculatorInputState extends State<CalculatorInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Numbers',
            hintText: 'Enter numbers (e.g., 1,2,3 or //;\\n1;2;3)',
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
          ),
          maxLines: 3,
          onChanged: (value) {
            context.read<CalculatorBloc>().add(InputChanged(value));
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is CalculatorLoading
                        ? null
                        : () {
                            context.read<CalculatorBloc>().add(
                              CalculateNumbers(_controller.text),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: state is CalculatorLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Calculate',
                            style: TextStyle(fontSize: 16),
                          ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _controller.clear();
                  context.read<CalculatorBloc>().add(ClearCalculation());
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                child: Text(
                  'Clear',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
