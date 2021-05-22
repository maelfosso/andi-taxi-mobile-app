import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart' as gbloc;
import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart' as ui;

class GMapView extends StatelessWidget {
  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    return SafeArea( 
        child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) => context.read<ui.GMapCubit>().mapCreated(controller),
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0
            ),
          ),
          BlocBuilder<gbloc.GMapBloc, gbloc.GMapState>(
            builder: (context, state) {
              print("BLOC BUILD : ${state.status}");
              
              switch (state.status) {
                case gbloc.GMapStatus.unknown:
                  
                  return Container(
                    height: 30.0,
                    color: Colors.blue,
                  );
                case gbloc.GMapStatus.home:
                  return Container(
                    height: 30.0,
                    color: Colors.redAccent,
                  );
                default:
                  return Container(
                    height: 50.0,
                    color: Colors.black,
                  );
              }
            }
          )
        ],
      )
    );
  }
}