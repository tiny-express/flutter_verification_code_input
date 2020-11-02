import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _onCompleted = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(child: new Text('Example verify code')),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Enter your code',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          VerificationCodeInput(
            keyboardType: TextInputType.number,
            length: 4,
            forceUpperCase: false,
            autofocus: false,
            onCompleted: (String value) {
              print(value);
              setState(() {
                _onCompleted = value;
              });
            },
          ),
          (_onCompleted != "")
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Your code: $_onCompleted',
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
