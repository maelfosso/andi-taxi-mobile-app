import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart';
import 'package:andi_taxi/pages/gmap/view/gmap_page.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GMapPage();
    // BlocProvider(
    //   create: (_) => GMapCubit(context.read<GeolocationRepository>()),
    //   child: GMap() // Will change according to the State of Home,
    // );
  }
}