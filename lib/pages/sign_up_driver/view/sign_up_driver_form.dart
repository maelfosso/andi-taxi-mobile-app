import 'package:andi_taxi/pages/sign_in/view/sign_in_page.dart';
import 'package:andi_taxi/pages/sign_up_driver/cubit/sign_up_driver_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpDriverForm extends StatelessWidget {
  
  SignUpDriverForm({Key? key}) : super(key: key);

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return BlocListener<SignUpDriverCubit, SignUpDriverState>(
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
          ],
        )
      )
    );
  }


  _buildBody() { 
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                margin: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.accentColor,
                      width: 1.0
                    )
                  )
                ),
                child: Text("Personal Informations"),
              ),
              _NameInput(),
              _PhoneInput(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                margin: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.accentColor,
                      width: 1.0
                    )
                  )
                ),
                child: Text("Driver Informations"),
              ),
              _RcIdentificationNumberInput(),
              _ResidenceAddressInput(),
              _RealResidenceAddressInput(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                margin: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: theme.accentColor,
                      width: 1.0
                    )
                  )
                ),
                child: Text("Car Informations"),
              ),
              _CarRegistrationNumberInput(),
              _CarModelInput(),
              _SignUpButton(),

            _Footer()
            ],
          ),
        )
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
    return BlocBuilder<SignUpDriverCubit, SignUpDriverState>(
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
                onChanged: (name) => context.read<SignUpDriverCubit>().nameChanged(name),
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
    return BlocBuilder<SignUpDriverCubit, SignUpDriverState>(
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
                onChanged: (phone) => context.read<SignUpDriverCubit>().phoneChanged(phone),
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

class _RcIdentificationNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpDriverCubit, SignUpDriverState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RC Identification Number",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (value) => context.read<SignUpDriverCubit>().rcIdentificationNumberChanged(value),
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

class _ResidenceAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpDriverCubit, SignUpDriverState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Residence Address",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (value) => context.read<SignUpDriverCubit>().residenceAddressChanged(value),
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

class _RealResidenceAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpDriverCubit, SignUpDriverState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Real Residence Address",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (value) => context.read<SignUpDriverCubit>().realResidenceAddressChanged(value),
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

class _CarRegistrationNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpDriverCubit, SignUpDriverState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Registration Number",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                onChanged: (value) => context.read<SignUpDriverCubit>().carRegistrationNumberChanged(value),
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

class _CarModelInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpDriverCubit, SignUpDriverState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Model",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // DropdownButton<String>(
              //   value: dropdownValue,
              //   icon: const Icon(Icons.arrow_downward),
              //   iconSize: 24,
              //   elevation: 16,
              //   style: const TextStyle(color: Colors.deepPurple),
              //   underline: Container(
              //     height: 2,
              //     color: Colors.deepPurpleAccent,
              //   ),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       dropdownValue = newValue!;
              //     });
              //   },
              //   items: <String>['One', 'Two', 'Free', 'Four']
              //       .map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
              TextField(
                onChanged: (value) => context.read<SignUpDriverCubit>().carModelChanged(value),
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

class _SignUpButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpDriverCubit, SignUpDriverState>(
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
                    ? () => context.read<SignUpDriverCubit>().signUpFormSubmitted()
                    : null,
                ),
              )
            );
      },
    );
  }
}
