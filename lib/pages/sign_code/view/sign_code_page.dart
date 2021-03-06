import 'package:andi_taxi/pages/sign_code/cubit/sign_code_cubit.dart';
import 'package:andi_taxi/pages/sign_code/view/sign_code_form.dart';
import 'package:andi_taxi/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:andi_taxi/pages/sign_in/view/sign_in_form.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignCodePage extends StatelessWidget {
  const SignCodePage({Key? key}): super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignCodePage());
  }

  // static Page page() => const MaterialPage<void>(child: SignCodePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context)!.signCode,
          style: TextStyle(
            color: Colors.black
          ),
        )
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => SignCodeCubit(context.read<AuthenticationRepository>()),
          child: SignCodeForm()
        )
      ),
    );
  }
}