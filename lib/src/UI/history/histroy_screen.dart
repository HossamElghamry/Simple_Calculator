import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator_task/src/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Expression History",
          style: TextStyle(
            fontFamily: "Calculator",
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<List<String>>(
            stream: globalBloc.history$,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data.length == 0) {
                return Center(
                  child: Text(
                    "No history to display",
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: "Calculator",
                        color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  index = snapshot.data.length - 1 - index;
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: ListTile(
                        trailing: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            globalBloc.expressionRecover(snapshot.data[index]);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Recover",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: "Calculator",
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: AutoSizeText(
                          snapshot.data[index],
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: "Calculator",
                              color: Colors.white),
                          maxLines: 3,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
