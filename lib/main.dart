import 'package:andi_taxi/blocs/app/bloc_observer.dart';
import 'package:andi_taxi/blocs/authentication/authentication_bloc.dart';
import 'package:andi_taxi/pages/home/home_page.dart';
import 'package:andi_taxi/pages/sign_code/view/sign_code_page.dart';
import 'package:andi_taxi/pages/splash/splash_page.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:andi_taxi/ui/welcome.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  Bloc.observer = AppBlocObserver();
  
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
  ));
}

class App extends StatelessWidget {
  
  App({
    Key? key,
    required AuthenticationRepository authenticationRepository
  }): _authenticationRepository = authenticationRepository,
      super(key: key);

  final AuthenticationRepository _authenticationRepository;
  
  @override
  Widget build(BuildContext context) {
    FlutterConfig.variables.forEach((k, v) {
      print('$k: $v');
    });

    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

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


  @override
  Widget build(BuildContext context) {
    MaterialColor color = new MaterialColor(0xFFC6902E, colorCodes);

    return MaterialApp(
      title: 'AnDi Taxi',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('ru', ''), // Russian, no country code
      ],
      theme: ThemeData(
        primaryColor: Color(0xFFC6902E),
        accentColor: Color(0xFF97ADB6),
        primarySwatch: color
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );

                break;
              case AuthenticationStatus.known:
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('Code : ${state.userCode.code}'))
                    ); 
                _navigator.pushAndRemoveUntil<void>(
                  SignCodePage.route(),
                  (route) => false,
                );

                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  Welcome.route(),
                  (route) => false,
                );

                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}