import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:andi_taxi/models/models.dart';
import 'package:andi_taxi/pages/gmap/view/gmap_page.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  User currentUser = User.empty;
  
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return FutureBuilder<User>(
      future: context.read<AuthenticationRepository>().currentUser,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          currentUser = snapshot.data!;
          return BlocBuilder<GMapBloc, GMapState>(
      builder: (context, state) {
        
        return new WillPopScope(
          onWillPop: () async {
            if (state.status == GMapStatus.home || ( 
              state.status == GMapStatus.bookingTaxi 
              && context.read<BookingTaxiBloc>().state.status == BookingTaxiStatus.home 
            )) {
              // Open the Drawer
              if (_scaffoldKey.currentState!.isDrawerOpen) {
                Navigator.of(context).pop();
                return false;
              }

              return true;
            } else if (state.status == GMapStatus.bookingTaxi) {
              context.read<BookingTaxiBloc>().add(BookingTaxiPreviousStep());
              return false;
            }
            return Future.value(false);
          },
          child: Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
                          state.status == GMapStatus.home 
                            || ( 
                              state.status == GMapStatus.bookingTaxi 
                              && context.read<BookingTaxiBloc>().state.status == BookingTaxiStatus.home 
                            )
                          ? Icons.sort 
                          : Icons.chevron_left
                        ),
                        color: Color(0xFF97ADB6),
                        onPressed: () {
                          // switch (state.status) {
                          if (state.status == GMapStatus.home || ( 
                            state.status == GMapStatus.bookingTaxi 
                            && context.read<BookingTaxiBloc>().state.status == BookingTaxiStatus.home 
                          )) {
                            // Open the Drawer
                            _scaffoldKey.currentState!.openDrawer();
                              // break;
                          } else if (state.status == GMapStatus.bookingTaxi) {
                            context.read<BookingTaxiBloc>().add(BookingTaxiPreviousStep());
                            //   break;
                            // default:
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: statusBarHeight + 160,
                    padding: EdgeInsets.only(top: statusBarHeight),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: Divider.createBorderSide(context),
                      ),
                      color: Color(0xFFC6902E),
                    ),
                    child: AnimatedContainer(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFC6902E),
                      ),
                      duration: const Duration(milliseconds: 250),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            fit: StackFit.passthrough,
                            overflow: Overflow.visible,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                                ),
                                child: Image(
                                  image: AssetImage('assets/images/ic_user.png')
                                ),
                              ),
                              Positioned(
                                top: -20.0,
                                right: -30.0,
                                child: InkWell(
                                  child: Image(
                                    image: AssetImage('assets/images/ic_edit.png')
                                  ),
                                  onTap: () {
                                    print("Edit the user information");
                                  },
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${currentUser.name}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${currentUser.phoneNumber}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ) 
                    ),
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.menuTravelHistory
                    ),
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.menuPayment
                    ),
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.menuPromoCode
                    ),
                  ),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.menuSoutient
                    ),
                  ),
                  Spacer(),
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.menuQuit
                    ),
                    onTap: () => context.read<AuthenticationRepository>().signOut(),
                  )
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
    );
  }
}