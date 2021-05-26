import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart' as gbloc;
import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart' as ui;

class GMapView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: BlocListener<ui.GMapCubit, ui.GMapState>(
        listener: (context, state) async {
          print('GMAPVIEW ... LISTENER');
          switch (state.error) {
            case 1:
              print('STATE ERROR !!! 1 - 1 -1');
              await Geolocator.openLocationSettings();
              break;
            case 2:

              break;
            case 3:

              break;
            default:
          }
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            _GoogleMap(),
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
      )
    );
  }
}

class _GoogleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CUSTOM GOOGLE MAP');
    return BlocBuilder<ui.GMapCubit, ui.GMapState>(
      builder: (context, state) {
        print('GMAP VIEW STATE : $state');
        print('CUStom GMap : ${state.currentPosition} - ${state.error}');
        print('SET OF MARKERS : ${Set<Marker>.of(state.markers.values)}');
        print("GEOLOCATION : ${state.currentPlace.locality}, ${state.currentPlace.street}, ${state.currentPlace.country}");
        print(state.currentPlace.toJson());
        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            print('ON MAP CREATED .. _GOOGLEMAP');
            context.read<ui.GMapCubit>().mapCreated(controller);
            print('ON MAP CREATED --- END OF CALL');
          },
          initialCameraPosition: CameraPosition(
            target: state.currentPosition,
            zoom: 11.0
          ),
          markers: Set<Marker>.of(state.markers.values),
        );
      }
    );
  }
}