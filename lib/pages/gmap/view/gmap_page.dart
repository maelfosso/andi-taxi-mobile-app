import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
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

    // return BlocProvider(
    //   create: (_) => ui.GMapCubit(context.read<GeolocationRepository>()),
    //   child: GMapView()
    // ); 
    return MultiBlocProvider(
      providers: [
        BlocProvider<ui.GMapCubit>(
          create: (BuildContext context) => ui.GMapCubit(context.read<GeolocationRepository>()),
        ),
        BlocProvider<BookingTaxiBloc>(
          create: (BuildContext context) => BookingTaxiBloc(
            geolocationRepository: context.read<GeolocationRepository>()
          ),
        ),
      ], 
      child: GMapView()
    );
  }
}

