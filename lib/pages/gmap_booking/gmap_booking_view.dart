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
            return _BookingTaxiAddressWidget();
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

class _BookingTaxiAddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0)
            )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
            ]
          )
        );
      }
    );    
  }
}