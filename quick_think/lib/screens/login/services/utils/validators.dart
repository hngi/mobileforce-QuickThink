import 'package:get/utils.dart';

class EmailValidator {
  static String validate(String value) {
    bool isEmail = GetUtils.isEmail(value);
    if(!isEmail){
      return 'Please enter a valid email';
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }
}