import 'package:andi_taxi/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:andi_taxi/pages/sign_in/view/sign_in_form.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:andi_taxi/ui/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}): super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignInPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context)!.signIn,
          style: TextStyle(
            color: Colors.black
          ),
        )
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
          
          child: BlocProvider(
            create: (_) => SignInCubit(context.read<AuthenticationRepository>()),
            child: SignInForm()
          )
        )
      )
    );
  }
}