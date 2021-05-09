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

  PageController _controller = PageController(
    initialPage: 0
  );

  final List<PVStepContent> pagesContents = [
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
    var content = pagesContents[index];

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
          return _buildPage(index % pagesContents.length);
        },
      )
    );
  }

  _buildDot() {
    return Container(
      child: Center(
        child: Text("dot ..."),
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