import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator_task/src/UI/history/histroy_screen.dart';
import 'package:calculator_task/src/global_bloc.dart';
import 'package:calculator_task/src/models/button_type.dart';
import 'package:calculator_task/src/models/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    initializeErrorListener(context);
    super.didChangeDependencies();
  }

  void initializeErrorListener(context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    globalBloc.errorflag$.listen(
      (error) {
        if (error) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Please enter a valid expression"),
              backgroundColor: Colors.red,
            ),
          );
          globalBloc.setErrorFalse();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.indigo,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.indigo, width: 5),
                ),
                child: ExpressionView(),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Container(
                  color: Colors.indigo,
                  child: ButtonsGridView(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExpressionView extends StatelessWidget {
  const ExpressionView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      child: Center(
        child: StreamBuilder<String>(
            stream: globalBloc.expression$,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.data == "") {
                return Text(
                  "Please Enter an Expression",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Calculator",
                    fontSize: 40,
                  ),
                );
              }
              return AutoSizeText(
                snapshot.data,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Calculator",
                    fontSize: 50),
                maxLines: 2,
              );
            }),
      ),
    );
  }
}

class ButtonsGridView extends StatelessWidget {
  ButtonsGridView({Key key}) : super(key: key);

  final List<CalculatorGridButton> buttonList = [
    CalculatorGridButton("1", ButtonType.Number),
    CalculatorGridButton("2", ButtonType.Number),
    CalculatorGridButton("3", ButtonType.Number),
    CalculatorGridButton("+", ButtonType.Operation),
    CalculatorGridButton("4", ButtonType.Number),
    CalculatorGridButton("5", ButtonType.Number),
    CalculatorGridButton("6", ButtonType.Number),
    CalculatorGridButton("-", ButtonType.Operation),
    CalculatorGridButton("7", ButtonType.Number),
    CalculatorGridButton("8", ButtonType.Number),
    CalculatorGridButton("9", ButtonType.Number),
    CalculatorGridButton("*", ButtonType.Operation),
    CalculatorGridButton("%", ButtonType.Operation),
    CalculatorGridButton("0", ButtonType.Number),
    CalculatorGridButton(".", ButtonType.Operation),
    CalculatorGridButton("/", ButtonType.Operation),
  ];

  final List<CalculatorGridButton> functionList = [
    CalculatorGridButton("sin", ButtonType.Function),
    CalculatorGridButton("cos", ButtonType.Function),
    CalculatorGridButton("tan", ButtonType.Function),
    CalculatorGridButton("1/", ButtonType.Function),
    CalculatorGridButton("^(1/2)", ButtonType.Function),
    CalculatorGridButton("e", ButtonType.Function),
    CalculatorGridButton("10", ButtonType.Function),
    CalculatorGridButton("^", ButtonType.Function),
    CalculatorGridButton("log", ButtonType.Function),
    CalculatorGridButton("!", ButtonType.Function),
    CalculatorGridButton("(", ButtonType.Operation),
    CalculatorGridButton(")", ButtonType.Operation),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Column(
      children: <Widget>[
        Flexible(
          flex: 5,
          child: PageView(
            children: <Widget>[
              GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return CalculatorButton(
                      calculatorGridButton: buttonList[index]);
                },
              ),
              GridView.builder(
                itemCount: functionList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return CalculatorButton(
                      calculatorGridButton: functionList[index]);
                },
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                child: RaisedButton(
                  elevation: 10,
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()),
                    );
                  },
                  child: Center(
                    child: Text(
                      "History",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Calculator",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                child: RaisedButton(
                  elevation: 10,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    globalBloc.handleInput(
                      CalculatorGridButton("C", ButtonType.C),
                    );
                  },
                  child: Center(
                    child: Text(
                      "C",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: "Calculator",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                child: RaisedButton(
                  elevation: 10,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  onPressed: () {
                    globalBloc.handleInput(
                      CalculatorGridButton("AC", ButtonType.AC),
                    );
                  },
                  child: Center(
                    child: Text(
                      "AC",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: "Calculator",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                child: RaisedButton(
                  elevation: 10,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () {
                    globalBloc.evaluateExpression();
                  },
                  child: Center(
                    child: Text(
                      "=",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: "Calculator",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final CalculatorGridButton calculatorGridButton;

  CalculatorButton({Key key, @required this.calculatorGridButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          _globalBloc.handleInput(calculatorGridButton);
        },
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: calculatorGridButton.type == ButtonType.Number
                ? Colors.white
                : Colors.cyan,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: calculatorGridButton.type == ButtonType.Number
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          child: Center(
            child: Text(
              calculatorGridButton.child,
              style: TextStyle(
                color: calculatorGridButton.type == ButtonType.Number
                    ? Colors.black
                    : Colors.white,
                fontSize: 32,
                fontFamily: "Calculator",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
