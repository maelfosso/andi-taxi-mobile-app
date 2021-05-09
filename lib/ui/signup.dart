import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {

  _buildBody() { 
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

            ),
            Container(
              
            ),
            Container(

            ),
            Container(
              child: ElevatedButton(
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  print('SignUp Button pressed');
                },
              ),
            )
          ],
        ),
      )
    );
  }

  _buildFooter() {
    TextStyle defaultStyle = TextStyle(
      color: Color(0xFF97ADB6)
    );
    TextStyle linkStyle = TextStyle(
      color: Color(0xFFC6902E),
      decoration: TextDecoration.underline
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: defaultStyle,
          children: <TextSpan>[
            TextSpan(
              text: 'Already have an account? '
            ),
            TextSpan(
              text: 'Sign In',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Terms of Service"');
                }
            ),
          ],
        )
      ),
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
          "Sign Up",
          style: TextStyle(
            color: Colors.black
          ),
        )
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildBody(),
            _buildFooter()
          ],
        )
      ),
    );
  }
}