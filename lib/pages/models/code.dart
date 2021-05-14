
import 'package:formz/formz.dart';

enum CodeValidationError { invalid }

class Code extends FormzInput<String, CodeValidationError> {
  const Code.pure() : super.pure('');
  const Code.dirty([String value = '']) : super.dirty(value);

  @override
  validator(String value) {
    return value.length != 4
      ? CodeValidationError.invalid
      : null
    ;
  }
}