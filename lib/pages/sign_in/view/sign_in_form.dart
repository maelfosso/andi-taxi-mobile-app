import 'package:andi_taxi/pages/sign_in/cubit/sign_in_cubit.dart';
import 'package:andi_taxi/pages/sign_up_customer/view/sign_up_customer_page.dart';
import 'package:andi_taxi/ui/welcome.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignInForm extends StatelessWidget {
  SignInForm({Key? key}) : super(key: key);

  ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign In Failure'))
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
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          _buildForm(),
          _buildSignInButtons()
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PhoneInput()
          ]
        ),
      ),   
    );
  }

  Widget _buildSignInButtons() {
    
    var divider = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: theme?.accentColor,
              height: 1.0,
            )
          ),
          Expanded(
            child: Container(
              child: Text(
                "OR",
                textAlign: TextAlign.center,
              )
            )
          ),
          Expanded(
            child: Container(
              color: theme?.accentColor,
              height: 1.0,
            )
          ),
        ],
      ),
    );

    var snButtons = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            child: InkWell(
              onTap: () {
                print('clic on facebook icon');
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/images/ic_facebook.png'),
                ),
              ),
            )
          ),
          Material(
            child: InkWell(
              onTap: () {
                print('clic on twitter icon');
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/images/ic_twitter.png'),
                ),
              ),
            )
          ),
          Material(
            child: InkWell(
              onTap: () {
                print('clic on gmail icon');
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/images/ic_gmail.png'),
                ),
              ),
            )
          )
        ],
      ),
    );

    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _SignInButton(),
            divider,
            snButtons
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
          style: defaultStyle,
          children: <TextSpan>[
            TextSpan(
              text: 'Don\'t have an account ? '
            ),
            TextSpan(
              text: 'Sign Up',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // SignUpCustomerPage.route();
                  Welcome.showSignUp(context);
                }
            ),
          ],
        )
      ),
    );
  }
}
class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              onChanged: (phone) => context.read<SignInCubit>().phoneChanged(phone),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF7F8F9),
                errorText: state.phone.invalid ? 'invalid phone number' : null,
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
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
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
                      "Sign In",
                      textAlign: TextAlign.center,
                    )
                  ),
                  onPressed: state.status.isValidated
                    ? () => context.read<SignInCubit>().signIn()
                    : null
                ),
              )
            );
      }
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => Navigator.of(context).push<void>(SignUpCustomerPage.route()),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
