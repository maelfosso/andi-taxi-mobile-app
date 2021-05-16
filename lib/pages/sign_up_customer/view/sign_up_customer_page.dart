import 'package:andi_taxi/pages/sign_up_customer/cubit/sign_up_customer_cubit.dart';
import 'package:andi_taxi/pages/sign_up_customer/view/sign_up_customer_form.dart';
import 'package:andi_taxi/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCustomerPage extends StatelessWidget {
  const SignUpCustomerPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpCustomerPage());
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
        child: BlocProvider<SignUpCustomerCubit>(
          create: (_) => SignUpCustomerCubit(context.read<AuthenticationRepository>()),
          child: const SignUpCustomerForm(),
        ),
      ),
    );
  }
}
