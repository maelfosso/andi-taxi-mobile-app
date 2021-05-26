import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GMapHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GMapBloc, GMapState>(
      builder: (context, state) {
        print('GMAP HOME $state');
        var place = state.location.place;

        return Container(
          child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Actual position",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    children: [
                      Material(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset('assets/images/ic_place.png'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "${place.locality}, ${place.subLocality}, ${place.street}",
                                style: TextStyle(
                                  // fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                place.country,
                                style: TextStyle(
                                  color: Color(0xFF97ADB6),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
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
                        "Book a taxi",
                        textAlign: TextAlign.center,
                      )
                    ),
                    onPressed: (){}
                    // state.status.isValidated
                    //   ? () => context.read<SignUpDriverCubit>().signUpFormSubmitted()
                    //   : null,
                  ),
                )
              ]
            )
          )
        );
      },
    );
    // Container(

    // );    
  }
}