import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart';
import 'package:andi_taxi/pages/gmap/view/gmap_page.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return GMapPage();
    return BlocProvider(
      create: (context) => GMapBloc(
        geolocationRepository: context.read<GeolocationRepository>(),
        bookingTaxiBloc: context.read<BookingTaxiBloc>()
      ),
      child: GMapPage()
    );
    // return BlocProvider(
    //   create: (_) => GMapCubit(context.read<GeolocationRepository>()),
    //   child: GMapPage() // Will change according to the State of Home,
    // );
  }
}