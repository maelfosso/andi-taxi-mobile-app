import 'package:andi_taxi/ui/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  Widget _buildSignInButtons() {
    return Expanded(
      child: Container(
        color: Colors.yellow
      )
    );
  }

  Widget _buildForm() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Phone number",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF7F8F9),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.0
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.0
                  )
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                isDense: true,
              ),
            )
          ]
        ),
      ),   
    );
  }

  Widget _buildBody() {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          _buildForm(),
          _buildSignInButtons()
        ],
      ),
    );
  }

  Widget _buildFooter() {
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
              text: 'Don\'t have an account ? '
            ),
            TextSpan(
              text: 'Sign Up',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator
                    .of(context)
                    .pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) => new SignUp())
                    );
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
          "Sign In",
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
            _buildBody(),
            _buildFooter()
          ],
        )
      ),
    );
  }
}