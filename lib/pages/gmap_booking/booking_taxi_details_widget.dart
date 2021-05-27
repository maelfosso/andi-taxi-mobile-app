part of 'gmap_booking_view.dart';

class BookingTaxiDetailsWidget extends StatelessWidget {
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
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Material(
                              child: 
                              // AspectRatio(
                              //   aspectRatio: 1,
                              //   child:
                                 Image(
                                  image: AssetImage('assets/images/ic_car_standard.png'),
                                  fit: BoxFit.scaleDown, // use this
                                ),
                              ),
                            // )                      
                          ),
                          Container(
                            child: Text(
                              "${state.car}",
                              style: TextStyle(
                                color: Color(0xFFC6902E),
                                fontSize: 20.0
                              ),
                            )
                          )
                        ]
                      )
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "\$${state.cost[0]} - \$${state.cost[1]}"
                            )                   
                          ),
                          Container(
                            child: Text("${state.time} min"),
                          )
                        ]
                      )
                    )
                  ]
                ),
              ),

              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "Duration"
                            )                 
                          ),
                          Container(
                            child: Text(
                              "${state.car}",
                              style: TextStyle(
                                color: Color(0xFFC6902E),
                                // fontSize: 10.0
                              ),
                            )
                          )
                        ]
                      )
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "\$${state.cost[0]} - \$${state.cost[1]}"
                            )                   
                          ),
                          Container(
                            child: Text("${state.time} min"),
                          )
                        ]
                      )
                    )
                  ],
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
                        "Book a Trip",
                        textAlign: TextAlign.center,
                      )
                    ),
                    // onPressed: () => context.read<ui.GMapCubit>().bookATaxi()
                    onPressed: () => context.read<BookingTaxiBloc>().add(BookingDetailsSetUp())                    
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
