import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
// import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart';
import 'package:andi_taxi/pages/gmap/view/gmap_page.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GMapBloc, GMapState>(
      builder: (context, state) {
        return new WillPopScope(
    onWillPop: () async {
      switch (state.status) {
        case GMapStatus.home :
          // Open the Drawer

          break;
        case GMapStatus.bookingTaxi:
          context.read<BookingTaxiBloc>().add(BookingTaxiPreviousStep());
          break;
        default:
      }
      return Future.value(false);
    },
    child: 
     Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: context.read<GMapBloc>().state.status == GMapStatus.searchingTaxi
          ? [
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 40, height: 40),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0.0),
                  primary: Colors.white,
                  shape: CircleBorder(),
                  elevation: 8.0
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.close
                  ),
                  color: Color(0xFF97ADB6),
                  onPressed: () {
                    
                  },
                )
              )
            )
          ] 
          : [
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 40, height: 40),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0.0),
                  primary: Colors.white,
                  shape: CircleBorder(),
                  elevation: 8.0
                ),
                child: IconButton(
                  icon: Icon(
                    state.status == GMapStatus.home ?  Icons.sort : Icons.chevron_left
                  ),
                  color: Color(0xFF97ADB6),
                  onPressed: () {
                    switch (state.status) {
                      case GMapStatus.home :
                        // Open the Drawer

                        break;
                      case GMapStatus.bookingTaxi:
                        context.read<BookingTaxiBloc>().add(BookingTaxiPreviousStep());
                        break;
                      default:
                    }
                  },
                )
              )
            ),
            Text(
              AppLocalizations.of(context)!.home,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 40, height: 40),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0.0),
                  primary: Colors.white,
                  shape: CircleBorder(),
                  elevation: 8.0
                ),
                child: IconButton(
                  icon: Icon(
                    state.status == GMapStatus.home ?  Icons.exit_to_app : Icons.cancel
                  ),
                  color: Color(0xFF97ADB6),
                  onPressed: () {
                    switch (state.status) {
                      case GMapStatus.home :
                        context.read<AuthenticationRepository>().signOut();
                        break;
                      case GMapStatus.bookingTaxi:
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Booking a taxi"),
                              content: Text(
                                "Are you sure you want to cancel the taxi booking ?"
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.pop(context, "No");
                                  },
                                ),
                                ElevatedButton(
                                  child: Text("Yes"),
                                  onPressed: () {
                                    Navigator.pop(context, "Yes");
                                  },
                                )
                              ],
                            );
                          },
                        ).then((val) {
                          if (val == "No") {

                          } else {
                            context.read<BookingTaxiBloc>().add(BookingTaxiStatusChanged(BookingTaxiStatus.canceled));
                          }
                        });

                        break;
                      default:
                    }
                  },
                )
              )
            )
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: GMapPage()
    )
        );
      }
    );
  }
}