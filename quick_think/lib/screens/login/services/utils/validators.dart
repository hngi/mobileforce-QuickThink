import 'package:get/utils.dart';

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Correct Email needed';
    }
    return null;
  }
}

class UsernameValidator {
  static String validate(String value) {
    if (value.trim().isEmpty) {
      return 'Field cannot be empty';
    }
    if (!RegExp(r"^[a-z0-9A-Z_-]{3,16}$").hasMatch(value.trim())) {
      return "can only include _ or -";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }
}
