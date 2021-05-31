part of 'gmap_booking_view.dart';

class BookingTaxiDetailsWidget extends StatelessWidget {
  
  String carType(CarType type) {
    switch (type) {
      case CarType.standard:
        return AppLocalizations.of(context)!.carStandard;
      
      default:
        return AppLocalizations.of(context)!.carStandard;
    }
  }

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
                padding: EdgeInsets.all(12.0),   
                margin: EdgeInsets.all(5.0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Material(
                              child: Image(
                                image: AssetImage('assets/images/ic_car_standard.png'),
                                fit: BoxFit.scaleDown, // use this
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "${carType(state.car)}",
                              style: TextStyle(
                                fontSize: 18.0
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
                              "\$${state.cost[0].toStringAsFixed(2)} - \$${state.cost[1].toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                              ),
                            )                   
                          ),
                          Container(
                            padding: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: Color(0xFFD5DEE2),
                            ),
                            child: Text(
                              "${(state.distance/1000).toStringAsFixed(2)} Km",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          )
                        ]
                      )
                    )
                  ]
                ),
              ),

              Container(
                padding: EdgeInsets.all(12.0),   
                margin: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              AppLocalizations.of(context)!.duration
                            )                 
                          ),
                          Container(
                            child: Text(
                              "~${state.time} min",
                              style: TextStyle(
                                color: Color(0xFFC6902E),
                                fontSize: 14.0
                              ),
                              textAlign: TextAlign.left,
                            )
                          )
                        ]
                      )
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Material(
                              child: Image(
                                image: AssetImage('assets/images/ic_mastercard.png'),
                                fit: BoxFit.scaleDown, // use this
                              ),
                            )        
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "**** 8462"
                            )
                          ),
                          // Container(
                          //   child: Text(
                          //     "\$${state.cost[0]} - \$${state.cost[1]}"
                          //   )                   
                          // ),
                          // Container(
                          //   child: Text("${state.time} min"),
                          // )
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
                        AppLocalizations.of(context)!.bookTrip,
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
