import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignCode extends StatefulWidget {
  @override
  _SignCode createState() => _SignCode();
}

class _SignCode extends State<SignCode> {

  Widget _buildCodeUI() {
    var textSentTo = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Code sent by SMS to",
          style: TextStyle(
            color: Theme.of(context).accentColor
          ),
        ),
        Text(
          "+33 234 556 7888",
          style: TextStyle(
            color: Theme.of(context).accentColor
          ),
        )
      ],
    );

    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textSentTo
          ],
        ),
      )
    );
  }

  Widget _buildKeyboard() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.yellow
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Enter the code",
          style: TextStyle(
            color: Colors.black
          ),
        )
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            _buildCodeUI(),
            _buildKeyboard()
          ],
        )
      ),
    );
  }
}