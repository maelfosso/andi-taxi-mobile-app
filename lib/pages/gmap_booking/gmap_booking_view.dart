import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GMapBookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        switch(state.status) {
          case BookingTaxiStatus.address:
            return Container(
              color: Colors.blue,
              width: 50.0,
            );
          case BookingTaxiStatus.details:
            return Container(
              color: Colors.blueAccent,
              width: 50.0,
            );
          case BookingTaxiStatus.payment:
            return Container(
              color: Colors.blueGrey,
              width: 50.0,
            );
          // case BookingTaxiStatus.unknown
          default:
            return Container(
              color: Colors.lightBlue,
              width: 50.0,
            );
        }
      }
    );
  }
}