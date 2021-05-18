import 'package:andi_taxi/blocs/app/app_bloc.dart';
import 'package:andi_taxi/blocs/authentication/authentication_bloc.dart';
import 'package:andi_taxi/pages/gmap/gmap_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }
  
  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: GMap()
      // Align(
      //   alignment: const Alignment(0, -1 / 3),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       Text(user.phoneNumber ?? '', style: textTheme.headline6),
      //       const SizedBox(height: 4.0),
      //       Text(user.name ?? '', style: textTheme.headline5),
      //     ],
      //   ),
      // ),
    );
  }
}
