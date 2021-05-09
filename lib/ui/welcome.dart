import 'dart:math';

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

  final _controller = PageController(
    initialPage: 0
  );

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

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

  _buildPage(int index) {
    var content = _pagesContents[index];

    // return ConstrainedBox(
    //   constraints: const BoxConstraints.expand(),
    return Center(
      child: Column(
        children: [
          Text(content.title),
          Text(content.description)
        ]
      ),
    );
  }
  

  _buildPageView() {
    return Expanded(
      child: new PageView.builder(
        scrollDirection: Axis.horizontal,
        physics: new AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          return _buildPage(index % _pagesContents.length);
        },
      )
    );
  }

  _buildDot() {
    return Container(
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
          child: Column(
            children: [
              Text('Welcome'),
              _buildPageView(),
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
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  Color color;

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