import 'package:calculator_task/src/models/button_type.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:rxdart/rxdart.dart';
import 'models/calculator_button.dart';

class GlobalBloc {
  BehaviorSubject<String> _expression$;
  BehaviorSubject<String> get expression$ => _expression$;

  BehaviorSubject<bool> _errorFlag$;
  BehaviorSubject<bool> get errorflag$ => _errorFlag$;

  BehaviorSubject<List<String>> _history$;
  BehaviorSubject<List<String>> get history$ => _history$;

  GlobalBloc() {
    _expression$ = BehaviorSubject<String>.seeded("");
    _errorFlag$ = BehaviorSubject<bool>.seeded(false);
    _history$ = BehaviorSubject<List<String>>.seeded([]);
  }

  void handleInput(CalculatorGridButton calculatorGridButton) {
    String previousExpression = _expression$.value;
    String newExpression;

    switch (calculatorGridButton.type) {
      case ButtonType.Number:
        newExpression = previousExpression + calculatorGridButton.child;
        break;
      case ButtonType.AC:
        newExpression = "";
        break;
      case ButtonType.C:
        newExpression =
            previousExpression.substring(0, (previousExpression.length - 1));
        break;
      case ButtonType.Operation:
        newExpression =
            previousExpression + " " + calculatorGridButton.child + " ";
        break;
      case ButtonType.Function:
        newExpression =
            previousExpression + " " + calculatorGridButton.child + " ";
        break;
      default:
    }
    _expression$.add(newExpression);
  }

  void evaluateExpression() {
    String expression = expression$.value;
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      dynamic result = exp.evaluate(EvaluationType.REAL, cm);
      String resultToDisplay = result.toString();
      expression$.add(resultToDisplay);

      List<String> historyListUpdate = _history$.value;
      historyListUpdate.add(expression);
      _history$.add(historyListUpdate);
    } catch (error) {
      _errorFlag$.add(true);
    }
  }

  void setErrorFalse() {
    _errorFlag$.add(false);
  }

  void expressionRecover(String expression) {
    _expression$.add(expression);
  }

  void dispose() {
    _expression$.close();
    _errorFlag$.close();
    _history$.close();
  }
}
