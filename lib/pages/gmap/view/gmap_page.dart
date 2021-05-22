import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatelessWidget {
  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {

    return BlocProvider<GMapCubit>(
      create: (_) => GMapCubit(),
      child: SafeArea( 
        child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) => context.read<GMapCubit>().mapCreated(controller),
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0
            ),
          ),
          Container(
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
                                  "Top",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Bottom",
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
                          "Select a place",
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
          )
        ],
      ))
    );
  }
}
