import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {

  _buildBody() { 
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.red,
      )
    );
  }

  _buildFooter() {
    return Container(
        color: Colors.yellow
      
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