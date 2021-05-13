import 'dart:math';

import 'package:andi_taxi/ui/sign_in.dart';
import 'package:andi_taxi/ui/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PVStepContent {
  final String title;
  final String description;
  
  PVStepContent(this.title, this.description);
}

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final mainKey = Key('main');
  final pageViewKey = Key('pv');
  final dotKey = Key('dot');
  final signBtnKey = Key('sign-btn');

  final _controller = PageController(
    initialPage: 0
  );

  bool _nextStep = false;

  static const _kDuration = const Duration(milliseconds: 0);

  static const _kCurve = Curves.ease;

  final List<PVStepContent> _pagesContents = [
    new PVStepContent(
      "Set your location", 
      "Enable location sharing so that your driver can see where you are"
    ),
    new PVStepContent(
      "Set your location", 
      "Enable location sharing so that your driver can see where you are"
    ),
    new PVStepContent(
      "Set your location", 
      "Enable location sharing so that your driver can see where you are"
    )
  ];

  _signUp() {
    Navigator
      .of(context)
      .pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => new SignUp())
      );
  }

  _signIn() {
    Navigator
      .of(context)
      .pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => new SignIn())
      );
  }

  _buildPage(int index) {
    var content = _pagesContents[index];

    return Container(
      padding: const EdgeInsets.all(75.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/welcome.png')),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child:Text(
            content.title,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          )),
          Text(
            content.description,
            textAlign: TextAlign.center,
          ),
        ]
      ),
    );
  }
  

  _buildPageView() {
    return Expanded(
      child: new PageView.builder(
        key: pageViewKey,
        scrollDirection: Axis.horizontal,
        physics: new AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemCount: _pagesContents.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildPage(index % _pagesContents.length);
        },        
        onPageChanged: (int index) {
          if (index == _pagesContents.length - 1) {
            setState(() {
              _nextStep = true;
            });
          }
        },
      )
    );
  }

  _buildSignButtons() {
    if (!_nextStep) {
      return Container();
    }

    return Container(
      key: signBtnKey,
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                )
              ),
              onPressed: _signUp
            ),
            TextButton(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                )
              ),
              onPressed: _signIn
            )
          ],
        ),
      ),
    );
  }

  _buildDot() {
    return Container(
      key: dotKey,
      padding: const EdgeInsets.all(25.0),
      child: new Center(
        child: new DotsIndicator(
          controller: _controller,
          itemCount: _pagesContents.length,
          onPageSelected: (int page) {
            _controller.animateToPage(
              page,
              duration: _kDuration,
              curve: _kCurve,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          key: mainKey,
          child: Column(
            children: [
              _buildPageView(),
              _buildSignButtons(),
              _buildDot()
            ],
          ),
        )
      )
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    bool current = (controller.page ?? controller.initialPage) == index;

    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          key: Key('dot_$index'),
          color: (current ? Colors.white : Colors.blue),
          type: MaterialType.circle,
          shadowColor: Colors.red,
          child: new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}