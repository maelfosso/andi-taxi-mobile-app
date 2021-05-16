import 'package:andi_taxi/api/response/user-code.dart';
import 'package:andi_taxi/blocs/authentication/authentication_bloc.dart';
import 'package:andi_taxi/pages/sign_code/cubit/sign_code_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignCodeForm extends StatelessWidget {
  SignCodeForm({Key? key}) : super(key: key);

  ThemeData? theme;

  UserCode? userCode;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    userCode = context.select((AuthenticationBloc bloc) => bloc.state.userCode);   

    return BlocListener<SignCodeCubit, SignCodeState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure'))
            );    
        } 
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            _buildCodeUI(),
            _buildKeyboard()
          ],
        )
      ),
    );
  }

  Widget _buildCodeUI() {
    var textSentTo = Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Code sent by SMS to",
            style: TextStyle(
              color: theme?.accentColor,
              fontSize: 18.0
            ),
          ),
          Text(
            userCode?.phoneNumber ?? '',
            style: TextStyle(
              color: theme?.accentColor,
              fontSize: 18.0
            ),
          )
        ],
      )
    );

    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textSentTo,
            _CodeUI()
          ],
        ),
      )
    );
  }

  Widget _buildKeyboard() {
    List<Widget> keys = List.generate(4, (i) => Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (j) {
            var index = i*3 + j;

            if (index == 11) {
              return _BackspaceButton();
            }
            if (index == 9) {
              return _SignCodeButton();              
            }
            return _DigitButton(index);
          })
        )
        )
      )
    );

    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: keys.toList(),
        )
      )
    );
  }

}

class _DigitButton extends StatelessWidget {
  final int index;

  const _DigitButton(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignCodeCubit, SignCodeState>(
      // buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              enableFeedback: true,
              child: Center(
                child: Text(
                  "${(index == 10) ? 0 : index + 1}",
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              onTap: () => context.read<SignCodeCubit>().digitAppend(index)
              // {

              //   print('key ${index+1}');

              //   if (_currentPosition < 4) {
              //     setState(() {
              //       _digits[_currentPosition] = "${(index == 10) ? 0 : index + 1}";
              //       _currentPosition += 1;
              //     });
              //   }
              // }
            )
          )
        );
      }
    );
  }
}

class _CodeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignCodeCubit, SignCodeState>(
      buildWhen: (previous, current) => previous.code.value != current.code.value || previous.timeout != current.timeout,
      builder: (context, state) {
        final currentContext = context.read<SignCodeCubit>();
        print('builder : $state');
        final splittenCode = state.code.value.split("");

        var digits = Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Widget>.generate(splittenCode.length, (index) => Container(
              width: 45.0,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2.0,
                    color: Color(0xFFC6902E)
                  )
                )
              ),
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              margin: EdgeInsets.all(5.0),
              child: Text(
                splittenCode[index] == 'x' ? ' ' : splittenCode[index],
                style: Theme.of(context).textTheme.headline3?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
                )
              ),
            ))
          ),
        );

        var resentCode = Container(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
            text: "Re-sent the code " + (state.timeout ? "" : "(0:${state.counter})"),
              style: TextStyle(
                color: state.timeout ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                decoration: TextDecoration.underline
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print("Resent the code SMS");
                  // _initTimer();
                  currentContext.signIn();
                  // currentContext.startTimer();
                }
            )
          ),
        );
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            digits,
            resentCode
          ],
        );
      },
    );
  }
}

class _BackspaceButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignCodeCubit, SignCodeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              enableFeedback: true,
              child: Center(
                child: Icon(
                  Icons.backspace,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onTap: () => context.read<SignCodeCubit>().digitRemoved()
            ),
          )
        );
      }
    );
  }
}

class _SignCodeButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignCodeCubit, SignCodeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
          ? const CircularProgressIndicator()
          : Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                enableFeedback: true,
                child: Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onTap: state.status.isValidated
                  ? () => context.read<SignCodeCubit>().signCode()
                  : null
              ),
            )
          );
      }
    );
  }
}
