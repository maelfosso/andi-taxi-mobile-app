import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignCode extends StatefulWidget {
  @override
  _SignCode createState() => _SignCode();
}

class _SignCode extends State<SignCode> {
  Timer _timer;
  int _counter;
  bool _timeout;

  static const int MAX_DURATION = 5;

  var _digits = List.filled(4, "");
  var _currentPosition = 0;

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_counter == 0) {
          setState(() {
            timer.cancel();
            _timeout = true;
          });
        } else {
          setState(() {
            _counter--;
          });
        }
      },
    );
  }

  void _initTimer() {
    setState(() {
      _timeout = false;
      _counter = MAX_DURATION;
    });
  }

  Widget _buildCodeUI() {
    var textSentTo = Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
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
      )
    );

    var digits = Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(_digits.length, (index) => Container(
          width: 45.0,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2.0,
                color: Color(0xFFC6902E)
              )
            )
          ),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          margin: EdgeInsets.all(5.0),
          child: Text(
            _digits[index],
            style: Theme.of(context).textTheme.headline3.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor
            )
          ),
        ))
      ),
    );

    var resentCode = Container(
      child: RichText(
        text: TextSpan(
        text: "Re-sent the code " + (_timeout ? "" : "(0:$_counter)"),
          style: TextStyle(
            color: _timeout ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
            decoration: TextDecoration.underline
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              print("Resent the code SMS");
              _initTimer();
              _startTimer();
            }
        )
      ),
    );

    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textSentTo,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                digits,
                resentCode
              ],
            )
          ],
        ),
      )
    );
  }

  Widget _buildKeyboard() {
    List<Widget> keys = List.generate(4, (i) => Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (j) {
            var index = i*3 + j;

            if (index == 11) {
              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    enableFeedback: true,
                    child: Center(
                      child: Icon(
                        Icons.backspace,
                        color: Color(0xFF97ADB6),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (_currentPosition > 0) {
                          _currentPosition -= 1;
                          _digits[_currentPosition] = "";
                        }
                      });
                    },
                  ),
                )
              );
            }
            if (index == 9) {
              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    enableFeedback: true,
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onTap: () {
                      print("submit the code");
                    },
                  ),
                )
              );
            }
            return Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  enableFeedback: true,
                  child: Center(
                    child: Text(
                      "${(index == 10) ? 0 : index + 1}",
                      style: Theme.of(context).textTheme.headline3.copyWith(
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                  onTap: () {
                    print('key ${index+1}');
                    if (_currentPosition < 4) {
                      setState(() {
                        _digits[_currentPosition] = "${(index == 10) ? 0 : index + 1}";
                        _currentPosition += 1;
                      });
                    }
                  }
                )
              )
            );
          })
        )
        )
      )
    );

    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: keys.toList(),
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _counter = MAX_DURATION;
    _timeout = false;
    _startTimer();

    _currentPosition = 0;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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