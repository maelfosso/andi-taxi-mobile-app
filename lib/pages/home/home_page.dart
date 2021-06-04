import 'package:andi_taxi/blocs/app/app_bloc.dart';
import 'package:andi_taxi/blocs/authentication/authentication_bloc.dart';
import 'package:andi_taxi/blocs/booking_taxi/booking_taxi_bloc.dart';
import 'package:andi_taxi/blocs/gmap/gmap_bloc.dart';
import 'package:andi_taxi/pages/gmap/cubit/gmap_cubit.dart';
import 'package:andi_taxi/pages/gmap/view/gmap_page.dart';
import 'package:andi_taxi/pages/home/home_view.dart';
import 'package:andi_taxi/repository/booking_taxi/booking_taxi_repository.dart';
import 'package:andi_taxi/repository/gmap/geolocation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Will have it's own state
// GMap for Google Map
// Chap for Chatting between two person (Driver or )
// History for History of client transaction
// Each state for each menu from Draw
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }
  
  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final GeolocationRepository geolocationRepository = GeolocationRepository();
    final BookingTaxiRepository bookingTaxiRepository = BookingTaxiRepository();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.home,
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(
              Icons.exit_to_app
            ),
            onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        // extend
      ),
      body: MultiRepositoryProvider(
        providers: [
          // RepositoryProvider<GeolocationRepository>(create: (context) => GeolocationRepository()),
          // RepositoryProvider<BookingTaxiRepository>(create: (context) => BookingTaxiRepository()),
          RepositoryProvider<GeolocationRepository>.value(value: geolocationRepository),
          RepositoryProvider<BookingTaxiRepository>.value(value: bookingTaxiRepository)
        ],
        child: BlocProvider<BookingTaxiBloc>(
          create: (BuildContext context) => BookingTaxiBloc(
            geolocationRepository: geolocationRepository, // context.read<GeolocationRepository>(),
            bookingTaxiRepository: bookingTaxiRepository, // context.read<BookingTaxiRepository>()
          ),
          child: HomeView(),
        ),
        // BlocProvider(
        //   create: ,
        //   child: HomeView(),
        // ) 
      )
    );
  }
}
