import 'dart:math' as math;

import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/models/payment-methods-used.dart';
import 'package:andi_taxi/models/user_position_place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'booking_taxi_address_widget.dart';
part 'booking_taxi_details_widget.dart';
part 'booking_taxi_payment_widget.dart';

class GMapBookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingTaxiBloc, BookingTaxiState>(
      listener: (context, state) {
        if (state.status == BookingTaxiStatus.canceled) {
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.btCanceled))
              ); 
        }
      },
      builder: (context, state) {
        print('[GMAP BOOKING VIEW] $state');

        switch(state.status) {
          case BookingTaxiStatus.address:
            return BookingTaxiAddressWidget();
          case BookingTaxiStatus.details:
            return BookingTaxiDetailsWidget();
          case BookingTaxiStatus.payment:
            return BookingTaxiPaymentWidget();
          case BookingTaxiStatus.canceled:
            
            return Container();
          default:
            print('[GMAP BOOKING VIEW] STATE STATUS : DEFAULT');
            return Container(
              // color: Colors.deepOrange,
              // width: 50.0,
            );
        }
      }
    );
  }
}
