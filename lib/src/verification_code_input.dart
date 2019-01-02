import 'package:flutter/material.dart';

class VerificationCodeInput extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final TextInputType keyboardType;
  final int length;
  EdgeInsetsGeometry padding;
  VerificationCodeInput({
    Key key,
    this.onCompleted,
    this.keyboardType,
    this.length = 4,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  _VerificationCodeInputState createState() =>
      new _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];
  Map<int, String> _code = Map();

  @override
  void initState() {
    // _code[1] = '1'
    if (_listFocusNode.isEmpty) {
      for (var i = 0; i < widget.length; i++) {
        _listFocusNode.add(new FocusNode());
        _listControllerText.add(new TextEditingController());
        _code[i] = " ";
      }
    }
    super.initState();
  }

  String _getInputVerify() {
    String verifycode = '';
    for (var i = 0; i < widget.length; i++) {
      for(var index = 0; index < _listControllerText[i].text.length; index ++){
        if(_listControllerText[i].text[index] != ' ') {
          verifycode += _listControllerText[i].text[index];
        }  
      }
    }
    return verifycode;
  }

  Widget _buildInputItem(int index) {
    return TextField(
      keyboardType: widget.keyboardType,
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
        if (value.length > 1 && index < widget.length ||
            index == 0 && value.isNotEmpty) {

          if (index == widget.length - 1) {
            widget.onCompleted(_getInputVerify());
            return;
          }
          if (_listControllerText[index + 1].value.text.isEmpty) {
            _listControllerText[index + 1].value =
                new TextEditingValue(text: " ");
          }
          if (value.length == 2) {
            if (value[0] != _code[index]) {
              _code[index] = value[0];
            } else if (value[1] != _code[index]) {
              _code[index] = value[1];
            }
            if (value[0] == " ") {
              _code[index] = value[1];
            }
            _listControllerText[index].text = _code[index];
          }
          _next(index);

          return;
        }
        if (value.isEmpty && index >= 0) {
          if (_listControllerText[index - 1].value.text.isEmpty) {
            _listControllerText[index - 1].value =
                new TextEditingValue(text: " ");
          }
          _prev(index);
        }
      },
      controller: _listControllerText[index],
      maxLengthEnforced: true,
      autocorrect: false,
      textAlign: TextAlign.center,
      autofocus: true,
      style: new TextStyle(fontSize: 25.0, color: Colors.black),
    );
  }

  void _next(int index) {
    if (index != widget.length) {
      FocusScope.of(context).requestFocus(_listFocusNode[index + 1]);
    }
  }

  void _prev(int index) {
    if (index > 0) {
      FocusScope.of(context).requestFocus(_listFocusNode[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 60,
            width: 60,
            child: Container(
                padding: EdgeInsets.all(8.0), child: _buildInputItem(index)),
          );
        },
      ),
    );
  }
}
