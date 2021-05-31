import 'package:andi_taxi/pages/sign_up_driver/cubit/sign_up_driver_cubit.dart';
import 'package:andi_taxi/pages/sign_up_driver/view/sign_up_driver_form.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:andi_taxi/ui/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpDriverPage extends StatelessWidget {
  const SignUpDriverPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpDriverPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "${AppLocalizations.of(context)!.signUp} ${AppLocalizations.of(context)!.signUpChoiceDriver}",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator
          .of(context)
          .pushReplacement(
            MaterialPageRoute<void>(builder: (_) => Welcome())
          );
          return false;
        },
        child: SafeArea( 
          child: BlocProvider<SignUpDriverCubit>(
            create: (_) => SignUpDriverCubit(context.read<AuthenticationRepository>()),
            child: SignUpDriverForm(),
          ),
        )
      ),
    );
  }
}
