
import 'package:formz/formz.dart';

enum CodeValidationError { invalid }

class Code extends FormzInput<String, CodeValidationError> {
  static const init = const ['','','',''];

  const Code.pure() : super.pure('xxxx');
  const Code.dirty([String value = 'xxxx']) : super.dirty(value);

  @override
  validator(String value) {
    return value.length != 4 || value.contains('x')
      ? CodeValidationError.invalid
      : null
    ;
  }
}