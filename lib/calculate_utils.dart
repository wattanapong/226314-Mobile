import 'dart:collection';

String evaluateExpression(String expression) {
  List<String> outputQueue = [];
  Queue<String> operatorStack = Queue<String>();

  int precedence(String op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
  }

  bool isOperator(String token) {
    return token == '+' || token == '-' || token == '*' || token == '/';
  }

  bool isNumber(String token) {
    return double.tryParse(token) != null;
  }

  // Tokenize the expression (split into numbers and operators)
  List<String> tokens = [];
  StringBuffer currentNumber = StringBuffer();

  for (int i = 0; i < expression.length; i++) {
    String char = expression[i];
    if (isOperator(char)) {
      if (currentNumber.isNotEmpty) {
        tokens.add(currentNumber.toString());
        currentNumber.clear();
      }
      tokens.add(char);
    } else if (char == ' ') {
      continue; // Ignore spaces
    } else {
      currentNumber.write(char);
    }
  }
  if (currentNumber.isNotEmpty) tokens.add(currentNumber.toString());

  // Shunting Yard Algorithm
  for (String token in tokens) {
    if (isNumber(token)) {
      outputQueue.add(token);
    } else if (isOperator(token)) {
      while (operatorStack.isNotEmpty &&
          precedence(operatorStack.first) >= precedence(token)) {
        outputQueue.add(operatorStack.removeFirst());
      }
      operatorStack.addFirst(token);
    }
  }

  while (operatorStack.isNotEmpty) {
    outputQueue.add(operatorStack.removeFirst());
  }

  // Evaluate the RPN (Reverse Polish Notation) expression
  Queue<double> evalStack = Queue<double>();

  for (String token in outputQueue) {
    if (isNumber(token)) {
      evalStack.addFirst(double.parse(token));
    } else if (isOperator(token)) {
      double b = evalStack.removeFirst();
      double a = evalStack.removeFirst();
      switch (token) {
        case '+':
          evalStack.addFirst(a + b);
          break;
        case '-':
          evalStack.addFirst(a - b);
          break;
        case '*':
          evalStack.addFirst(a * b);
          break;
        case '/':
          evalStack.addFirst(a / b);
          break;
      }
    }
  }

  // The result should be the only item left in the evalStack
  return evalStack.first.toString();
}