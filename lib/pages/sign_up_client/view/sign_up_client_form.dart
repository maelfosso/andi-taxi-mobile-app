import 'package:andi_taxi/pages/sign_in/view/sign_in_page.dart';
import 'package:andi_taxi/pages/sign_up_client/cubit/sign_up_client_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpClientForm extends StatelessWidget {
  const SignUpClientForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpClientCubit, SignUpClientState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            _buildBody(),
            _Footer()
          ],
        )
      )
    );
  }


  _buildBody() { 
    return Expanded(
      flex: 1,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NameInput(),
            _PhoneInput(),
            _SignUpButton()
            
            
          ],
        ),
      )
    );
  }
  
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(
      color: Color(0xFF97ADB6)
    );
    TextStyle linkStyle = TextStyle(
      color: Color(0xFFC6902E),
      decoration: TextDecoration.underline
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Already have an account? ',
              style: defaultStyle,
            ),
            TextSpan(
              text: 'Sign In',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Sign In Tap');
                  Navigator
                      .of(context)
                      .pushAndRemoveUntil<void>(
                        SignInPage.route(),
                        // SignUpDriverPage.route(),
                        (route) => false,
                      );
                }
            ),
          ],
        )
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpClientCubit, SignUpClientState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (name) => context.read<SignUpClientCubit>().nameChanged(name),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF7F8F9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.0
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0
                    )
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                  isDense: true,
                ),
              )
            ]
          ),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpClientCubit, SignUpClientState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phone number",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (phone) => context.read<SignUpClientCubit>().phoneChanged(phone),
                decoration: InputDecoration(
                  errorText: state.phone.invalid ? 'invalid phone number' : null,
                  filled: true,
                  fillColor: Color(0xFFF7F8F9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.0
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0
                    )
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                ),
              )
            ]
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpClientCubit, SignUpClientState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                semanticsLabel: 'Linear progress indicator',
              )
            : Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              child: SizedBox(
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
                      "Sign Up",
                      textAlign: TextAlign.center,
                    )
                  ),
                  onPressed: state.status.isValidated
                    ? () => context.read<SignUpClientCubit>().signUpFormSubmitted()
                    : null,
                ),
              )
            );
      },
    );
  }
}
