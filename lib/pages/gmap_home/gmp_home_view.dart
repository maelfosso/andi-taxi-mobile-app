import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart' as gbloc;
import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GMapHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<gbloc.GMapBloc, gbloc.GMapState>(
      builder: (context, state) {
        print('GMAP HOME $state');
        var place = state.location.place;

        return Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)
              )
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    AppLocalizations.of(context)!.actualPosition,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Material(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset('assets/images/ic_place.png'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: 
                            // Flexible(
                            //   child:
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              // SizedBox(
                              //   width: double.infinity,
                              //   child: 
                                Container(
                              child: 
                              Text(
                                "${place.locality}, ${place.subLocality}, ${place.street}",
                                style: TextStyle(
                                  // fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                // softWrap: false,
                                // maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            // )
                              ),
                            // ),
                            Container(
                              child: Text(
                                place.country,
                                style: TextStyle(
                                  color: Color(0xFF97ADB6),
                                ),
                              ),
                            )
                          ],
                        ),
                            )
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                      )
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        AppLocalizations.of(context)!.bookTaxi,
                        textAlign: TextAlign.center,
                      )
                    ),
                    // onPressed: () => context.read<ui.GMapCubit>().bookATaxi()
                    onPressed: () => context.read<gbloc.GMapBloc>().add(gbloc.GMapStatusChanged(gbloc.GMapStatus.bookingTaxi)),
                  ),
                )
              ]
            )
          )
        );
      },
    );
  }
}