import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart' as gbloc;
import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart' as ui;
import 'package:andi_taxi/pages/gmap/view/gmap_view.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => ui.GMapCubit(context.read<GeolocationRepository>()),
      child: GMapView()
    ); 
  }
}

