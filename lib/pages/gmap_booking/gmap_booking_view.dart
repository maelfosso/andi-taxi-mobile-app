import 'dart:math' as math;

import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GMapBookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        switch(state.status) {
          case BookingTaxiStatus.address:
            return _BookingTaxiAddressWidget();
          case BookingTaxiStatus.details:
            return Container(
              color: Colors.blueAccent,
              width: 50.0,
            );
          case BookingTaxiStatus.payment:
            return Container(
              color: Colors.blueGrey,
              width: 50.0,
            );
          // case BookingTaxiStatus.unknown
          default:
            return Container(
              color: Colors.lightBlue,
              width: 50.0,
            );
        }
      }
    );
  }
}

class _BookingTaxiAddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0)
            )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD5DDE0),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    ),
                    BoxShadow(
                      color: Color(0xFFD5DDE0),
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(0, 0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: IntrinsicHeight(child: 
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(                  
                              borderRadius: BorderRadius.all(
                                Radius.circular(40.0),
                              ),
                              color: Color(0xFFC6902E),
                            ),
                            width: 10.0,
                            height: 10.0,
                          ),
                          Expanded(
                            child: 
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              width: 1.0,
                              color: Color(0xFFD5DDE0),
                            )
                          ),
                          CustomPaint(
                            size: Size(10.0, 10.0),
                            painter: _ShapesPainter(Color(0xFFD5DDE0))
                          )
                        ],
                      )
                    ),
                    Expanded(child: 
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Departure address",
                                style: TextStyle(
                                  fontSize: 17.0
                                ),
                              )
                            ),
                            Container(
                              height: 1.0,
                              margin: EdgeInsets.symmetric(vertical: 14.0),
                              color: Color(0xFFD5DDE0),
                            ),
                            Container(
                              child: Text(
                                "Finish address",
                                style: TextStyle(
                                  fontSize: 17.0
                                ),
                              )
                            )
                          ],
                        )
                      )
                    )
                  ],
                )
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: IntrinsicHeight(child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Material(
                          child: 
                          AspectRatio(
                            aspectRatio: 5/3,
                            child: Image(
                              image: AssetImage('assets/images/ic_setloc.png'),
                              fit: BoxFit.scaleDown, // use this
                            ),
                          ),
                        )                      
                      ),
                      Text(
                        "Display on the Map",
                        style: TextStyle(
                          color: Color(0xFFC6902E),
                          fontSize: 20.0
                        ),
                      )
                    ],
                  ),
                )
              ),
              Container(
                // color: Colors.yellow.shade700,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Recent Addresses",
                        style: TextStyle(
                          color: Color(0xFFD5DDE0),
                          fontSize: 20.0
                        ),
                      )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset('assets/images/ic_place_grey.png'),
                            ),
                          ),
                          Expanded(child: 
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Country",
                                    style: TextStyle(
                                      color: Color(0xFF97ADB6),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Color(0xFF97ADB6),
                                  height: 1.0,
                                  margin: EdgeInsets.only(top: 20.0),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    )
                  ]
                ),
              )
            ]
          )
        );
      }
    );    
  }
}

class _ShapesPainter extends CustomPainter {
  final Color color;
  _ShapesPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
 
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width/2, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _DrawTriangleShape extends CustomPainter {
 
  late Paint painter;
 
  DrawTriangleShape() {
 
    painter = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.fill;
 
  }
  
  @override
  void paint(Canvas canvas, Size size) {
 
    var path = Path();
 
    path.moveTo(size.width/2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
 
    canvas.drawPath(path, painter);
  }
 
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}