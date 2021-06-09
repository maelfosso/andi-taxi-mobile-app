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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GMapBloc, GMapState>(
      builder: (context, state) {
        
        return new WillPopScope(
          onWillPop: () async {
            switch (state.status) {
              case GMapStatus.home :
                // Open the Drawer
                if (_scaffoldKey.currentState!.isDrawerOpen) {
                  Navigator.of(context).pop();
                  return false;
                }

                return true;
              case GMapStatus.bookingTaxi:
                context.read<BookingTaxiBloc>().add(BookingTaxiPreviousStep());
                break;
              default:
            }
            return Future.value(false);
          },
          child: Scaffold(
              key: _scaffoldKey,

            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // leading: Container(),
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
                              // Scaffold.of(context).openEndDrawer();
                              _scaffoldKey.currentState!.openDrawer();
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
                  BlocBuilder<BookingTaxiBloc, BookingTaxiState>(
                    builder: (context, state) {
                      String title = "";

                      if (state.status == BookingTaxiStatus.address) {
                        title = AppLocalizations.of(context)!.titleBTAddressSelection; // "Address selection";
                      } else if (state.status == BookingTaxiStatus.details) {
                        title = AppLocalizations.of(context)!.titleBTDetails; // "Details";
                      } else if (state.status == BookingTaxiStatus.payment) {
                        title = AppLocalizations.of(context)!.titleBTPayment; // "Payment";
                      } else {
                        title = AppLocalizations.of(context)!.home;
                      }
                      return Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      );
                    },
                  ),
                  // Text(
                  //   title,
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold
                  //   ),
                  // ),
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
                                    title: Text(AppLocalizations.of(context)!.dgCancelTitle),
                                    content: Text(AppLocalizations.of(context)!.dgCancelContent),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text(AppLocalizations.of(context)!.no),
                                        onPressed: () {
                                          Navigator.pop(context, "No");
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text(AppLocalizations.of(context)!.ok),
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
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Messages'),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ],
              ),
            ),
            body: GMapPage()
          )
        );
      }
    );
  }
}