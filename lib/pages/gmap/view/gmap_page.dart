import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatelessWidget {
  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {

    return BlocProvider<GMapCubit>(
      create: (_) => GMapCubit(),
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) => context.read<GMapCubit>().mapCreated(controller),
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0
        ),
      )
    );
  }
}

// class GMap extends StatefulWidget {
//   @override
//   _GMapState createState() => _GMapState();
// }

// class _GMapState extends State<GMap> {
//   late GoogleMapController mapController;

//   final LatLng _center = const LatLng(45.521563, -122.677433);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       onMapCreated: _onMapCreated,
//       initialCameraPosition: CameraPosition(
//         target: _center,
//         zoom: 11.0,
//       ),
//     );
//   }
// }
