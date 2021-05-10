import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignCode extends StatefulWidget {
  @override
  _SignCode createState() => _SignCode();
}

class _SignCode extends State<SignCode> {

  var _inputs = List.filled(4, "X");

  Widget _buildCodeUI() {
    var textSentTo = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Code sent by SMS to",
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 18.0
          ),
        ),
        Text(
          "+33 234 556 7888",
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 18.0
          ),
        )
      ],
    );

    var inputs = Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(_inputs.length, (index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 5.0,
                color: Color(0xFFC6902E)
              )
            )
          ),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          margin: EdgeInsets.all(5.0),
          child: Text(
            _inputs[index],
            style: Theme.of(context).textTheme.headline3.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor
            )
          ),
        ))
      ),
    );

    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textSentTo,
            inputs
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