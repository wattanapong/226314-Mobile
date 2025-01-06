
import 'package:flutter/material.dart';
import 'calculate_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(iy
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Calculator(title: 'Calculator'),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});
  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '0';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
      } else if (value == '=') {
        try {
          display = evaluateExpression(display);
        } catch (e) {
          display = 'Error';
        }
      } else {
        if (display == '0') {
          display = value;
        } else {
          display += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            display,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton('7'),
            buildButton('8'),
            buildButton('9'),
            buildButton('/'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton('4'),
            buildButton('5'),
            buildButton('6'),
            buildButton('*'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton('1'),
            buildButton('2'),
            buildButton('3'),
            buildButton('-'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton('0'),
            buildButton('.'),
            buildButton('='),
            buildButton('+'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton('C'),
          ],
        ),
      ],
    );
  }

  Widget buildButton(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onButtonPressed(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // shape: CircleBorder(),
          shape: const RoundedRectangleBorder(),
          minimumSize: const Size(80, 80),
        ),
        child: Text(label, style: const TextStyle(fontSize: 24)),
      ),
    );
  }


}

