import 'package:flutter/material.dart';

void main() => runApp(Mycalc());

class Mycalc extends StatefulWidget {
  @override
  _MycalcState createState() => _MycalcState();
}

class _MycalcState extends State<Mycalc> {
  double _output=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "calculator",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Our calculator"),
          ),
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[Text(_output.toString(), style: TextStyle(fontSize: 23))],
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: (){
                      setState(() {
                        _output=1;
                      });
                      print(_output);

                    },
                    child: Text("1"),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

