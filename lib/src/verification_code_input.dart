import 'package:flutter/material.dart';
import 'dart:async';

class VerificationCodeInput extends StatefulWidget {
  VerificationCodeInput({this.onCompleted, this.keyboardType, this.length = 4});
  final ValueChanged<String> onCompleted;
  final TextInputType keyboardType;
  final int length;

  @override
  _verificationCodeInputState createState() => new _verificationCodeInputState(
      onCompleted: onCompleted,
      keyboardType: this.keyboardType,
      length: length);
}

class _verificationCodeInputState extends State<VerificationCodeInput> {
  _verificationCodeInputState(
      {this.onCompleted,
      this.keyboardType = TextInputType.number,
      this.length = 4});

  ValueChanged<String> onCompleted;
  TextInputType keyboardType = TextInputType.number;
  int length = 0;

  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];

  String _getInputVerify() {
    String verifycode = '';
    for (var i = 0; i < length; i++) {
      for(var index = 0; index < _listControllerText[i].text.length; index ++){
        if(_listControllerText[i].text[index] != ' ') {
          verifycode += _listControllerText[i].text[index];
        }  
      }
    }
    return verifycode;
  }

  Widget _createItem(int index) {
    Flexible flexible = Flexible(
      child: new TextField(
        keyboardType: keyboardType,
        enabled: false,
        maxLines: 1,
        maxLength: 2,
        focusNode: _listFocusNode[index],
        decoration: InputDecoration(
          enabled: true,
          counterText: "",
          contentPadding: new EdgeInsets.all(10.0),
          errorMaxLines: 1,
          fillColor: Colors.black),
        onChanged: (String value) {
          if (value.length > 1 && index < length || index == 0 && value.isNotEmpty) {
            if (index == length - 1) {
              widget.onCompleted(_getInputVerify());
              return;
            }
            _listControllerText[index + 1].value = new TextEditingValue(text: " ");
            FocusScope.of(context).requestFocus(_listFocusNode[index + 1]);
            return;
          }
          if (value.isEmpty && index >= 0) {
             _listControllerText[index - 1].value = new TextEditingValue(text: " ");                       
            FocusScope.of(context).requestFocus(_listFocusNode[index - 1]);
          }
        },
        controller: _listControllerText[index],
        maxLengthEnforced: true,
        autocorrect: false,
        textAlign: TextAlign.center,
        autofocus: true,
        style: new TextStyle(fontSize: 25.0, color: Colors.black),
      ),
    );
    return flexible;
  }

  List<Widget> _createListItem() {
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
        listWidget.add(_createItem(j++));
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
          children: _createListItem()),
    );
  }
}
