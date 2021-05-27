import 'dart:math' as math;

import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/models/user_position_place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_taxi_address_widget.dart';
part 'booking_taxi_details_widget.dart';
part 'booking_taxi_payment_widget.dart';

class GMapBookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
      builder: (context, state) {
        switch(state.status) {
          case BookingTaxiStatus.address:
            return BookingTaxiAddressWidget();
          case BookingTaxiStatus.details:
            return BookingTaxiDetailsWidget();
          case BookingTaxiStatus.payment:
            return BookingTaxiPaymentWidget();
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
