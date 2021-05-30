
part of 'gmap_booking_view.dart';

class BookingTaxiAddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        final fromPlace = state.from.place;
        final toPlace = state.to.place;

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
                                "${fromPlace.locality}, ${fromPlace.subLocality}, ${fromPlace.street}",
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
                                toPlace == UserPositionPlace.empty 
                                  ? "" 
                                  : "${toPlace.locality}, ${toPlace.subLocality}, ${toPlace.street}",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                        textAlign: TextAlign.left,
                      )
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        children: state.lastPositions.map((e) {
                          return Row(
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
                                      margin: EdgeInsets.only(top: 15.0),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          );
                        }).toList(),
                      )
                    )
                  ]
                ),
              ),
              Container(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                      )
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        "Next: Booking details",
                        textAlign: TextAlign.center,
                      )
                    ),
                    // onPressed: () => context.read<ui.GMapCubit>().bookATaxi()
                    onPressed: fromPlace != UserPositionPlace.empty && toPlace != UserPositionPlace.empty
                      ? () => context.read<BookingTaxiBloc>().add(BookingAddressSetUp())
                      : null
                    
                  ),
                )
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
