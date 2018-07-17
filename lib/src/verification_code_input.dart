import 'package:flutter/material.dart';

class VerificationCodeInput extends StatefulWidget {
  VerificationCodeInput({this.onCompleted, this.keyboardType, this.length = 4});
  final ValueChanged<String> onCompleted;
  final TextInputType keyboardType;
  final int length;

  @override
  verificationCodeInputState createState() => new verificationCodeInputState(
      onCompleted: onCompleted,
      keyboardType: this.keyboardType,
      length: length);
}

class verificationCodeInputState extends State<VerificationCodeInput> {
  verificationCodeInputState(
      {this.onCompleted,
      this.keyboardType = TextInputType.number,
      this.length = 4});

  ValueChanged<String> onCompleted;
  TextInputType keyboardType = TextInputType.number;
  int length = 0;

  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];

  String getInputVerify() {
    String verifycode = '';
    for (var i = 0; i < length; i++) {
      verifycode += _listControllerText[i].text;
    }
    print(verifycode);
    return verifycode;
  }

  Widget createItem(int index) {
    Flexible flexible = Flexible(
        child: new TextField(
      keyboardType: keyboardType,
      enabled: _listControllerText[index].text.length == 1,
      maxLines: 1,
      maxLength: 1,
      focusNode: _listFocusNode[index],
      decoration: InputDecoration(
          enabled: false,
          counterText: "",
          contentPadding: new EdgeInsets.all(10.0),
          errorMaxLines: 1,
          fillColor: Colors.black),
      onChanged: (String value) {
        if (value.length > 0 && index < length) {
          if (index == length - 1) {
            widget.onCompleted(getInputVerify());
            return;
          }
          FocusScope.of(context).requestFocus(_listFocusNode[index + 1]);
        }
        if (value.isEmpty && index >= 0) {
          FocusScope.of(context).requestFocus(_listFocusNode[index - 1]);
        }
      },
      controller: _listControllerText[index],
      maxLengthEnforced: true,
      autocorrect: false,
      textAlign: TextAlign.center,
      autofocus: true,
      style: new TextStyle(fontSize: 25.0, color: Colors.black),
    ));
    return flexible;
  }

  List<Widget> createListItem() {
    List<Widget> listWidget = <Widget>[];
    int numberVerification = length;
    if (_listFocusNode.isEmpty) {
      for (var i = 0; i < numberVerification; i++) {
        _listFocusNode.add(new FocusNode());
        _listControllerText.add(new TextEditingController());
      }
    }
    for (var i = 0, j = 0; i < numberVerification * 2; i++) {
      if (i % 2 == 0) {
        listWidget.add(createItem(j++));
      } else {
        if (j < numberVerification) {
          listWidget.add(new Padding(
            padding: new EdgeInsets.all(5.0),
          ));
        }
      }
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.only(left: 50.0, right: 50.0),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: createListItem()),
    );
  }
}
