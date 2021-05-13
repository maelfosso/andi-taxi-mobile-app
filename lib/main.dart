import 'package:andi_taxi/blocs/app/app_bloc.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:andi_taxi/ui/welcome.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
  ));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  
  App({
    Key? key,
    required AuthenticationRepository authenticationRepository
  }): _authenticationRepository = authenticationRepository,
      super(key: key);

  final AuthenticationRepository _authenticationRepository;
  
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final Map<int, Color> colorCodes = {
    50: Color.fromRGBO(198, 144, 46, .1),
    100: Color.fromRGBO(198, 144, 46, .2),
    200: Color.fromRGBO(198, 144, 46, .3),
    300: Color.fromRGBO(198, 144, 46, .4),
    400: Color.fromRGBO(198, 144, 46, .5),
    500: Color.fromRGBO(198, 144, 46, .6),
    600: Color.fromRGBO(198, 144, 46, .7),
    700: Color.fromRGBO(198, 144, 46, .8),
    800: Color.fromRGBO(198, 144, 46, .9),
    900: Color.fromRGBO(198, 144, 46, 1),
  };

  AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor color = new MaterialColor(0xFFC6902E, colorCodes);

    return MaterialApp(
      title: 'AnDi Taxi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFC6902E),
        accentColor: Color(0xFF97ADB6),
        primarySwatch: color
      ),
      home: Welcome()
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}