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
  get key => null;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(child: new Text('Example verify code')),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Enter your code', style: TextStyle(fontSize: 20.0),),
            ),
            Expanded(
              flex: 1,
              child: VerificationCodeInput(
                keyboardType: TextInputType.number,
                length: 4,
                padding: EdgeInsets.only(left: 80, right: 80),
                onCompleted: (String value) {
                  print(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
