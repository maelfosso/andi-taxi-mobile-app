import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/pages/gmap_booking/gmap_booking_page.dart';
import 'package:andi_taxi/pages/gmap_home/gmp_home_view.dart';
import 'package:andi_taxi/pages/gmap_searching/gmap_searching_page.dart';
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
    return BlocListener<ui.GMapCubit, ui.GMapState>(
      listener: (context, state) async {
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
                  // Waiting for the current position
                  return Container(
                    height: 30.0,
                    color: Colors.blue,
                  );
                case gbloc.GMapStatus.home:
                  return GMapHome();
                
                case gbloc.GMapStatus.bookingTaxi:
                  return GMapBookingPage();

                case gbloc.GMapStatus.searchingTaxi:
                  return GMapSearchingPage();
                  
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

class _GoogleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CUSTOM GOOGLE MAP');
    return BlocBuilder<ui.GMapCubit, ui.GMapState>(
      builder: (context, state) {
        print('SET OF MARKERS : ${Set<Marker>.of(state.markers.values)}');
        Set<Circle> circles = Set.from([
          Circle(
            circleId: CircleId("current-location"),
            center: state.currentPosition,
            radius: 50,
            fillColor: Color(0xFFC6902E),
            strokeWidth: 0,
            strokeColor: Color(0xFFC6902E),
          )
        ]);

        return GoogleMap(
          onTap: (LatLng latLng) {
            print('TAPPEDD ---- ${context.read<gbloc.GMapBloc>().state.status} -- ${gbloc.GMapStatus.bookingTaxi}');
            if (
              context.read<gbloc.GMapBloc>().state.status == gbloc.GMapStatus.bookingTaxi &&
              context.read<BookingTaxiBloc>().state.status == BookingTaxiStatus.address
            ) {
              context.read<BookingTaxiBloc>().add(DestinationAddressAdded(latLng));
              context.read<ui.GMapCubit>().addMarker(latLng);
            }
          },
          onMapCreated: (GoogleMapController controller) {
            context.read<ui.GMapCubit>().mapCreated(controller);
          },
          initialCameraPosition: CameraPosition(
            target: state.currentPosition,
            zoom: 16.0
          ),
          mapType: MapType.normal,
          // trafficEnabled: true,
          // markers: Set<Marker>.of(state.markers.values),
          circles: circles,
          polylines: Set<Polyline>.of(state.polylines.values),
          // compassEnabled: true,
          myLocationEnabled: true,
        );
      }
    );
  }
}