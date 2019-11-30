import 'package:calculator_task/src/UI/main_page/main_page.dart';
import 'package:calculator_task/src/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CalculatorTask());
}

class CalculatorTask extends StatefulWidget {
  @override
  _CalculatorTaskState createState() => _CalculatorTaskState();
}

class _CalculatorTaskState extends State<CalculatorTask> {
  GlobalBloc _globalBloc;

  @override
  void initState() {
    _globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: _globalBloc,
      child: MaterialApp(
        home: MainPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
      ),
    );
  }
}
