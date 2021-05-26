import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/pages/gmap_booking/gmap_booking_view.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GMapBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Booking a taxi"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => BookingTaxiBloc(
          geolocationRepository: context.read<GeolocationRepository>()
        ),
        child: GMapBookingView()
      )
    );
  }
}