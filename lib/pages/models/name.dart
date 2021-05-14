
import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  validator(String value) {
    return value.isEmpty
      ? NameValidationError.invalid
      : null
    ;
  }
}