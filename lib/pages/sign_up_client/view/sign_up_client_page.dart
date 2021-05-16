import 'package:andi_taxi/pages/sign_up_client/cubit/sign_up_client_cubit.dart';
import 'package:andi_taxi/pages/sign_up_client/view/sign_up_client_form.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpClientPage extends StatelessWidget {
  const SignUpClientPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpClientPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpClientCubit>(
          create: (_) => SignUpClientCubit(context.read<AuthenticationRepository>()),
          child: const SignUpClientForm(),
        ),
      ),
    );
  }
}
