import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  
  _buildDot() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text("Welcome"),
          )
          // Column(
          //   children: [
              
          //   ],
          // ),
        )
      )
    );
  }
}